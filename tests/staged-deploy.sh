#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
COMMON_LIB="$ROOT/shared/install-common.sh"
STAGE_ROOT=$(mktemp -d /tmp/mcsr-setup-staged.XXXXXX)
cleanup_stage() {
    local status=$?
    if [[ "$status" == 0 || "${MCSR_KEEP_STAGE:-0}" != 1 ]]; then
        rm -rf -- "$STAGE_ROOT"
    else
        printf 'Preserved failed staged tree at %s\n' "$STAGE_ROOT" >&2
    fi
}
trap cleanup_stage EXIT

FAKE_BIN="$STAGE_ROOT/fake-bin"
mkdir -p "$FAKE_BIN"
cat >"$FAKE_BIN/id" <<'SH'
#!/usr/bin/env bash
case "${1-}" in
    -un) printf 'mcsrtest\n' ;;
    -nG) printf '\n' ;;
    -u) printf '1000\n' ;;
    -g) printf '1000\n' ;;
    *) exec /usr/bin/id "$@" ;;
esac
SH
cat >"$FAKE_BIN/systemctl" <<'SH'
#!/usr/bin/env bash
exit 0
SH
cat >"$FAKE_BIN/sudo" <<'SH'
#!/usr/bin/env bash
exec "$@"
SH
cat >"$FAKE_BIN/pacman" <<'SH'
#!/usr/bin/env bash
if [[ "${1-}" == -Qq && "${2-}" == waybar ]]; then exit 0; fi
if [[ "${1-}" == -R ]]; then printf '%s\n' "$*" >>"${MCSR_TEST_PACMAN_LOG:?}"; fi
exit 0
SH
cat >"$FAKE_BIN/pkill" <<'SH'
#!/usr/bin/env bash
exit 0
SH
cat >"$FAKE_BIN/archlinux-java" <<'SH'
#!/usr/bin/env bash
case "${1-}" in
    get) printf 'none\n' ;;
    status) : ;;
esac
SH
chmod 755 "$FAKE_BIN"/*
export PATH="$FAKE_BIN:$PATH"
export MCSR_TEST_PACMAN_LOG="$STAGE_ROOT/pacman.log"
export MCSR_STAGING=1 MCSR_STAGE_HARDLINK_INSTANCES=0

assert() {
    [[ "$1" ]] || { printf 'STAGED TEST FAILED: %s\n' "$2" >&2; exit 1; }
}

stage_variant() {
    local variant=$1 platform=$2 tier=$3 home="$STAGE_ROOT/$1/home/mcsrtest"
    local system="$STAGE_ROOT/$1/root"
    mkdir -p "$home/.config/foot" "$system"
    printf 'pre-install foot config\n' >"$home/.config/foot/foot.ini"

    ROOT="$ROOT" MCSR_VARIANT="$variant" MCSR_PLATFORM="$platform" MCSR_TIER="$tier" \
        MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$home" MCSR_SYSTEM_ROOT="$system" \
        bash -c '
            set -Eeuo pipefail
            source "$ROOT/shared/install-common.sh"
            begin_rollback_state
            if [[ "$MCSR_PLATFORM" == wayland ]]; then
                deploy_rendered "$ROOT/wayland/helpers/jay" "$TARGET_HOME/.local/bin/jay" 755
                printf "#!/usr/bin/env bash\\nexit 0\\n" >"$TARGET_HOME/.local/bin/jay.real"
                printf "#!/usr/bin/env bash\\nexit 0\\n" >"$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
                chmod 755 "$TARGET_HOME/.local/bin/jay.real" "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
            fi
            deploy_common_configuration
            if [[ "$MCSR_PLATFORM" == wayland ]]; then deploy_wayland_configuration; else deploy_x11_configuration; fi
            enable_system_services
            post_deploy_sanity_check
            deploy_common_configuration
            if [[ "$MCSR_PLATFORM" == wayland ]]; then deploy_wayland_configuration; else deploy_x11_configuration; fi
            post_deploy_sanity_check
            create_dovers_artifacts
            finish_rollback_state
            printf "%s\\n" "$ROLLBACK_STATE" >"$TARGET_HOME/.test-state-path"
        '

    if [[ "$platform" == wayland ]]; then
        assert "$(grep -Fq 'layout = "gb,no"' "$home/.config/jay/config.toml" && printf yes)" "Jay desktop layout"
        assert "$(grep -Fq 'layout = "mcsr"' "$home/.config/waywall/init.lua" && printf yes)" "Waywall MCSR XKB"
        assert "$(grep -Fq "Exec=$home/.local/bin/jay run" "$system/usr/share/wayland-sessions/jay.desktop" && printf yes)" "absolute Jay session command"
        assert "$(readlink -f "$home/.config/xkb/symbols/mcsr" | grep -Fx "$home/MCSR/wayland/xkb/symbols/mcsr" && printf yes)" "XKB source symlink"
        for path in \
            "$home/.config/jay/config.toml" "$home/.config/waywall/init.lua" \
            "$home/.config/foot/foot.ini" "$home/.config/zellij/config.kdl" \
            "$home/.config/yazi/yazi.toml" "$home/.config/yazi/keymap.toml" \
            "$home/.config/waybar/config" "$home/.config/waybar/style.css" \
            "$home/.config/obs-studio/basic/scenes/JAY_wayland.json" \
            "$home/.config/obs-studio/basic/profiles/optimized/basic.ini" \
            "$home/.config/systemd/user/xdg-desktop-portal-jay.service" \
            "$home/launcher/instances/waywall/instance.json" \
            "$home/MCSR/CrossDisplayManager/jarfiles/Ninjabrain-Bot-1.5.2.jar" \
            "$system/etc/keyd/normal.conf" "$system/usr/share/xdg-desktop-portal/portals/jay.portal"; do
            assert "$(test -e "$path" && printf yes)" "missing staged destination: $path"
        done
        for name in background.png crosshair.png overlay_tall.png overlay_thin.png overlay_wide.png \
            measuring_overlay.png stretched_overlay.png set-dpi.py Ninjabrain-Bot-1.5.2.jar \
            paceman-tracker-0.7.2.jar fix-ninbot-hotkeys.py; do
            assert "$(test -f "$home/.config/waywall/resources/$name" && printf yes)" "missing Waywall asset: $name"
        done
        assert "$(grep -Fq 'MCSR_SETUP_WAYBAR_START' "$home/.config/jay/config.toml" && printf yes)" "Waybar startup marker"
        assert "$(test -x "$home/.local/bin/foot-tabbed" && test -x "$home/.local/bin/yazi-edit" && printf yes)" "executable user helpers"
        if rg -I -l '/home/nathan|@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' \
            "$home/.config/jay" "$home/.config/waywall" "$home/.config/foot" \
            "$home/.config/zellij" "$home/.config/yazi" "$home/.config/waybar" \
            "$home/.config/obs-studio" "$home/.local/bin" "$home/.local/share/applications" \
            "$home/launcher/instances/waywall/instance.json" >/dev/null; then
            rg -n -I '/home/nathan|@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' \
                "$home/.config/jay" "$home/.config/waywall" "$home/.config/foot" \
                "$home/.config/zellij" "$home/.config/yazi" "$home/.config/waybar" \
                "$home/.config/obs-studio" "$home/.local/bin" "$home/.local/share/applications" \
                "$home/launcher/instances/waywall/instance.json" || :
            printf 'Runtime path/template leak in staged Wayland deployment.\n' >&2
            exit 1
        fi
        instance_id=$(jq -r '.id' "$home/launcher/instances/waywall/instance.json")
        assert "$([[ "$instance_id" == waywall ]] && printf yes)" "Wayland instance identity"

        printf 'user edit after install\n' >>"$home/.config/yazi/yazi.toml"
        printf 'waybar\n' >"$(<"$home/.test-state-path")/packages.added"
        HOME="$home" "$home/DoOvers/undo-waybar.sh"
        assert "$(grep -Fq 'exec = "foot-tabbed"' "$home/.config/jay/config.toml" && printf yes)" "Waybar undo preserves Jay bindings"
        assert "$(! grep -Fq 'MCSR_SETUP_WAYBAR_START' "$home/.config/jay/config.toml" && printf yes)" "Waybar undo removes only marked startup"
        assert "$(grep -Fq -- '-R --noconfirm waybar' "$MCSR_TEST_PACMAN_LOG" && printf yes)" "Waybar undo requests non-recursive package removal"
        assert "$(! grep -Fxq waybar "$(<"$home/.test-state-path")/packages.added" && printf yes)" "Waybar package rollback record updated"
        HOME="$home" "$home/DoOvers/reset.sh"
        assert "$(grep -Fxq 'pre-install foot config' "$home/.config/foot/foot.ini" && printf yes)" "rollback restores prior file"
        assert "$(grep -Fq 'user edit after install' "$home/.config/yazi/yazi.toml" && printf yes)" "rollback preserves subsequent user edit"
        assert "$(test ! -e "$home/.local/bin/yazi-edit" && printf yes)" "rollback removes unchanged installer-created helper"
        assert "$(test ! -e "$home/.config/jay/config.toml" && printf yes)" "rollback removes updated installer-created Jay config"
    else
        assert "$(test -f "$home/.config/i3/config" && test -f "$home/launcher/instances/MCSRRanked/instance.json" && printf yes)" "X11 config/instance destinations"
        instance_id=$(jq -r '.id' "$home/launcher/instances/MCSRRanked/instance.json")
        assert "$([[ "$instance_id" == MCSRRanked ]] && printf yes)" "X11 instance identity"
        assert "$(grep -Fq '"javaPath": "/usr/lib/jvm/java-21-openjdk/bin/java"' "$home/launcher/instances/MCSRRanked/instance.json" && printf yes)" "X11 MCSR instance remains pinned to Java 21"
    fi
    printf 'STAGED PASS: %s (home=%s)\n' "$variant" "$home"
}

stage_variant NLmcsrWL.sh wayland NL
stage_variant NLmcsrX11.sh x11 NL
cleanup_home="$STAGE_ROOT/cleanup/home/mcsrtest"
cleanup_repo="$cleanup_home/mcsr-setup"
mkdir -p "$cleanup_repo/.git" "$cleanup_repo/shared"
touch "$cleanup_repo/NLmcsrWL.sh" "$cleanup_repo/shared/install-common.sh"
ROOT="$cleanup_repo" MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$cleanup_home" \
    MCSR_VARIANT=NLmcsrWL.sh MCSR_PLATFORM=wayland MCSR_TIER=NL MCSR_STAGING=0 \
    MCSR_COMMON_LIB="$COMMON_LIB" \
    bash -c '
        set -Eeuo pipefail
        source "$MCSR_COMMON_LIB"
        safe_cleanup_checkout
    '
assert "$(! test -e "$cleanup_repo" && printf yes)" "guarded checkout cleanup removes only exact validated checkout"

failure_home="$STAGE_ROOT/failure/home/mcsrtest"
mkdir -p "$failure_home"
set +e
failure_output=$(ROOT="$ROOT" MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$failure_home" \
    MCSR_VARIANT=NLmcsrWL.sh MCSR_PLATFORM=wayland MCSR_TIER=NL \
    bash -c '
        set -Eeuo pipefail
        source "$ROOT/shared/install-common.sh"
        setup_logging
        stage "intentional failure test"
        die "staged expected failure"
    ' 2>&1)
failure_status=$?
set -e
assert "$([[ "$failure_status" -ne 0 ]] && printf yes)" "failure path exits nonzero"
assert "$(grep -Fq 'MCSR SETUP FAILED' <<<"$failure_output" && printf yes)" "failure is visible to terminal"
assert "$(grep -Fq 'staged expected failure' "$failure_home/mcsr-setup-NLmcsrWL.sh.log" && printf yes)" "failure is retained in installer log"
assert "$(! grep -Fq 'MCSR SETUP COMPLETE' <<<"$failure_output" && printf yes)" "failure path cannot print completion"
printf 'Staged deployment/idempotency/rollback/Waybar-undo checks passed. No packages, services, live configs, or checkout were changed.\n'
