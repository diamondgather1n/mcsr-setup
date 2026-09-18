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

"$ROOT/tests/preflight-validation.sh"
"$ROOT/tests/rollback-locale.sh"
bash "$ROOT/tests/reset-session-safe.sh"
bash "$ROOT/tests/service-variants.sh"

assert() {
    [[ "$1" ]] || { printf 'STAGED TEST FAILED: %s\n' "$2" >&2; exit 1; }
}

assert_file_payload() {
    python3 - "$1" "$2" "$3" "$4" "$5" <<'PY'
import pathlib, stat, sys
src, dst = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
home, user, platform = sys.argv[3:6]
replacements = {
    b'@HOME@': home.encode(), b'@USER@': user.encode(),
    b'@OBS_COLLECTION@': b'JAY (wayland)' if platform == 'wayland' else b'I3 (x11)',
    b'@OBS_SCENE_FILE@': b'JAY_wayland' if platform == 'wayland' else b'I3_x11',
}
data = src.read_bytes()
for old, new in replacements.items():
    data = data.replace(old, new)
if not dst.is_file() or dst.read_bytes() != data:
    raise SystemExit(f'file payload differs: {src} -> {dst}')
expected_mode = 0o755 if src.stat().st_mode & 0o111 else 0o644
if stat.S_IMODE(dst.stat().st_mode) != expected_mode:
    raise SystemExit(f'file mode differs: {src} -> {dst}')
PY
}

assert_tree_payload() {
    python3 - "$1" "$2" "$3" "$4" "$5" "$6" <<'PY'
import os, pathlib, stat, sys
src, dst = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
home, user, platform = sys.argv[3:6]
replacements = {
    b'@HOME@': home.encode(), b'@USER@': user.encode(),
    b'@OBS_COLLECTION@': b'JAY (wayland)' if platform == 'wayland' else b'I3 (x11)',
    b'@OBS_SCENE_FILE@': b'JAY_wayland' if platform == 'wayland' else b'I3_x11',
}
def entries(root):
    return {
        p.relative_to(root).as_posix(): p
        for p in root.rglob('*')
        if (p.is_file() or p.is_symlink())
        and '__pycache__' not in p.parts
        and p.suffix != '.pyc'
    }
left, right = entries(src), entries(dst)
exact = sys.argv[6] == 'exact'
if (exact and set(left) != set(right)) or (not exact and not set(left).issubset(right)):
    missing, extra = sorted(set(left)-set(right)), sorted(set(right)-set(left))
    raise SystemExit(f'tree inventory differs {src} -> {dst}; missing={missing}; extra={extra}')
for rel, source in left.items():
    target = right[rel]
    if source.is_symlink():
        if not target.is_symlink() or os.readlink(source) != os.readlink(target):
            raise SystemExit(f'symlink differs: {source} -> {target}')
        continue
    data = source.read_bytes()
    for old, new in replacements.items():
        data = data.replace(old, new)
    if not target.is_file() or target.read_bytes() != data:
        raise SystemExit(f'tree file differs: {source} -> {target}')
    expected_mode = 0o755 if source.stat().st_mode & 0o111 else 0o644
    if stat.S_IMODE(target.stat().st_mode) != expected_mode:
        raise SystemExit(f'tree mode differs: {source} -> {target}')
PY
}

stage_variant() {
    local variant=$1 platform=$2 tier=$3 home="$STAGE_ROOT/$1/home/mcsrtest"
    local system="$STAGE_ROOT/$1/root"
    local instance=waywall
    local dpi_state
    local -a runtime_paths
    [[ "$platform" == wayland ]] || instance=MCSRRanked
    assert "$(grep -Fq 'sudo usermod -aG openrazer "$TARGET_USER"' "$ROOT/shared/install-common.sh" && printf yes)" "OpenRazer sysfs access group is granted"
    mkdir -p "$home/.config/foot" "$system"
    printf 'pre-install foot config\n' >"$home/.config/foot/foot.ini"
    printf '# existing login profile\n' >"$home/.bash_profile"

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
        assert "$(grep -Fxq 'rightcontrol = leftmeta' "$system/etc/keyd/normal.conf" && printf yes)" "Right Ctrl keyd mapping"
        assert "$(grep -Fxq 'mouse2 = home' "$system/etc/keyd/normal.conf" && grep -Fxq 'mouse1 = backspace' "$system/etc/keyd/normal.conf" && printf yes)" "keyd mouse mappings"
        assert "$(grep -Fq 'logo-d =' "$home/.config/jay/config.toml" && grep -Fq 'exec = "jay-desktop-launcher"' "$home/.config/jay/config.toml" && test -x "$home/.local/bin/jay-desktop-launcher" && grep -Fq '/usr/bin/bemenu-run' "$home/.local/bin/jay-desktop-launcher" && printf yes)" "Right Ctrl+D launcher command chain"
        assert "$(grep -Fq 'logo-Return' "$home/.config/jay/config.toml" && test -x "$home/.local/bin/foot-tabbed" && printf yes)" "Right Ctrl+Enter terminal command chain"
        assert "$(grep -Fq 'request_ninbot_state = function(delay_ms)' "$home/.config/waywall/init.lua" && grep -Fq 'repair_ninbot_hotkeys()' "$home/.config/waywall/init.lua" && grep -Fq 'path = true' "$home/.config/waywall/init.lua" && printf yes)" "Waywall live behavior and portable DPI configuration"
        if [[ "$tier" == NL ]]; then
            assert "$(grep -Fq '["F3"] = DISABLED' "$home/.config/waywall/init.lua" && printf yes)" "NL Waywall retains its F3 disable mapping"
            assert "$(grep -Fq 'wide = { key = "*-N", f3_safe = false, ingame_only = false }' "$home/.config/waywall/init.lua" && printf yes)" "NL Waywall retains its intended Wide macro behavior"
        else
            assert "$(grep -Fq 'wide = { key = "*-N", f3_safe = false, ingame_only = true }' "$home/.config/waywall/init.lua" && printf yes)" "L Waywall retains its existing Wide macro behavior"
        fi
        assert "$(grep -Fq 'bind_shift_hotbar("*-Shift-2", "1")' "$home/.config/waywall/init.lua" && grep -Fq 'bind_shift_hotbar("*-Shift-7", "6")' "$home/.config/waywall/init.lua" && printf yes)" "Ranked Shift+2..7 piechart bindings retained"
        dpi_state="$STAGE_ROOT/dpi-state-$variant"
        if XDG_STATE_HOME="$dpi_state" python3 "$home/.config/waywall/resources/set-dpi.py" invalid >/dev/null 2>&1; then
            assert "" "DPI helper rejects invalid input"
        fi
        assert "$(test -x "$home/.config/waywall/resources/set-dpi.py" && test -s "$dpi_state/waywall-dpi.log" && printf yes)" "DPI helper executable and persistent diagnostic"
        for path in \
            "$home/.config/jay/config.toml" "$home/.config/waywall/init.lua" \
            "$home/.config/foot/foot.ini" "$home/.config/zellij/config.kdl" \
            "$home/.config/yazi/yazi.toml" "$home/.config/yazi/keymap.toml" \
            "$home/.config/micro/settings.json" "$home/.config/rncbc.org/qpwgraph.conf" \
            "$home/.config/obs-studio/basic/scenes/JAY_wayland.json" \
            "$home/.config/obs-studio/basic/profiles/Untitled/basic.ini" \
            "$home/.config/obs-studio/basic/profiles/fuzzy/basic.ini" \
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
        if [[ "$tier" == NL ]]; then
            assert "$(grep -Fxc 'show-bar = false' "$home/.config/jay/config.toml")" "NL disables Jay's built-in bar"
            assert "$(grep -Fc 'MCSR_SETUP_WAYBAR_START' "$home/.config/jay/config.toml")" "NL has exactly one marked Waybar startup"
            assert "$(grep -Fc 'exec = [\"waybar\"]' "$home/.config/jay/config.toml")" "NL starts exactly one Waybar instance"
            assert "$(grep -Fxc '# MCSR_SETUP_LOCAL_BIN_PATH_START' "$home/.bash_profile")" "NL adds one Bash login PATH block"
            login_jay=$(env -i HOME="$home" USER=mcsrtest LOGNAME=mcsrtest PATH=/usr/bin:/bin \
                bash --login -c 'command -v jay')
            assert "$([[ "$login_jay" == "$home/.local/bin/jay" ]] && printf yes)" "fresh Bash login resolves jay from local bin"
        else
            assert "$(grep -Fxc 'show-bar = true' "$home/.config/jay/config.toml")" "L retains its existing Jay bar setting"
            assert "$(! grep -Fq 'MCSR_SETUP_WAYBAR_START' "$home/.config/jay/config.toml" && printf yes)" "L remains free of the NL Waybar startup"
        fi
        assert "$(test -x "$home/.local/bin/foot-tabbed" && test -x "$home/.local/bin/yazi-edit" && printf yes)" "executable user helpers"
        if [[ "$tier" == NL ]]; then
            assert "$(test ! -e "$home/.local/bin/jay-startup-windows" && test ! -e "$home/.local/bin/input-recorder" && printf yes)" "NL excludes L-only startup helpers"
        fi
        if [[ "${MCSR_RUN_SYSTEMD_VERIFY:-0}" == 1 ]] && command -v systemd-analyze >/dev/null; then
            local unit_log="$STAGE_ROOT/systemd-$variant.log"
            if ! systemd-analyze verify \
                "$home/.config/systemd/user/xdg-desktop-portal-jay.service" \
                "$home/.config/systemd/user/obs-input-overlay.service" >"$unit_log" 2>&1; then
                cat "$unit_log" >&2
                exit 1
            fi
        fi
        runtime_paths=(
            "$home/.config/jay" "$home/.config/waywall" "$home/.config/foot"
            "$home/.config/zellij" "$home/.config/yazi"
            "$home/.config/obs-studio" "$home/.config/micro" "$home/.config/rncbc.org"
            "$home/.local/bin" "$home/.local/share/applications"
            "$home/launcher/instances/waywall/instance.json"
        )
        [[ "$tier" != NL ]] || runtime_paths+=("$home/.config/waybar")
        if rg -I -l '/home/nathan|@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' "${runtime_paths[@]}" >/dev/null; then
            rg -n -I '/home/nathan|@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' "${runtime_paths[@]}" || :
            printf 'Runtime path/template leak in staged Wayland deployment.\n' >&2
            exit 1
        fi
        instance_id=$(jq -r '.id' "$home/launcher/instances/waywall/instance.json")
        assert "$([[ "$instance_id" == waywall ]] && printf yes)" "Wayland instance identity"

    else
        assert "$(test -f "$home/.config/i3/config" && test -f "$home/launcher/instances/MCSRRanked/instance.json" && printf yes)" "X11 config/instance destinations"
        instance_id=$(jq -r '.id' "$home/launcher/instances/MCSRRanked/instance.json")
        assert "$([[ "$instance_id" == MCSRRanked ]] && printf yes)" "X11 instance identity"
        assert "$(grep -Fq '"javaPath": "/usr/lib/jvm/java-21-openjdk/bin/java"' "$home/launcher/instances/MCSRRanked/instance.json" && printf yes)" "X11 MCSR instance remains pinned to Java 21"
    fi
    assert "$(test -L "$home/MCSR/CrossDisplayManager/MCSRlauncher/launcher" && test "$(readlink -- "$home/MCSR/CrossDisplayManager/MCSRlauncher/launcher")" = "$home/launcher" && test -f "$home/MCSR/CrossDisplayManager/MCSRlauncher/launcher/options.json" && test -f "$home/MCSR/CrossDisplayManager/MCSRlauncher/launcher/instances/$instance/instance.json" && printf yes)" "launcher sibling runtime resolves selected instance via canonical directory"
    printf 'STAGED PAYLOAD PARITY: %s\n' "$variant"
    assert_tree_payload "$ROOT/shared/scripts" "$home/.local/bin" "$home" mcsrtest "$platform" subset
    assert_tree_payload "$ROOT/shared/foot" "$home/.config/foot" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/zellij" "$home/.config/zellij" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/yazi" "$home/.config/yazi" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/micro" "$home/.config/micro" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/qpwgraph" "$home/.config/rncbc.org" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/obs/profiles" "$home/.config/obs-studio/basic/profiles" "$home" mcsrtest "$platform" exact
    assert_tree_payload "$ROOT/shared/obs/assets" "$home/MCSR/CrossDisplayManager/obs images" "$home" mcsrtest "$platform" exact
    assert_file_payload "$ROOT/shared/obs/global.ini" "$home/.config/obs-studio/global.ini" "$home" mcsrtest "$platform"
    assert_file_payload "$ROOT/shared/obs/user.ini" "$home/.config/obs-studio/user.ini" "$home" mcsrtest "$platform"
    if [[ "$platform" == wayland ]]; then
        assert_tree_payload "$ROOT/wayland/waywall/resources" "$home/.config/waywall/resources" "$home" mcsrtest "$platform" exact
        assert_file_payload "$ROOT/wayland/waywall/${tier}-init.lua" "$home/.config/waywall/init.lua" "$home" mcsrtest "$platform"
        if [[ "$tier" == NL ]]; then
            assert_tree_payload "$ROOT/wayland/waybar" "$home/.config/waybar" "$home" mcsrtest "$platform" exact
        fi
        assert_file_payload "$ROOT/shared/obs/scenes/JAY_wayland.json" "$home/.config/obs-studio/basic/scenes/JAY_wayland.json" "$home" mcsrtest "$platform"
        for name in index.html overlay.css overlay.js; do
            assert_file_payload "$ROOT/shared/obs/input-overlay/$name" "$home/.local/share/obs-input-overlay/$name" "$home" mcsrtest "$platform"
        done
        assert_file_payload "$ROOT/shared/obs/input-overlay/obs-input-overlay" "$home/.local/bin/obs-input-overlay" "$home" mcsrtest "$platform"
        assert_file_payload "$ROOT/shared/obs/input-overlay/obs-input-overlay.service" "$home/.config/systemd/user/obs-input-overlay.service" "$home" mcsrtest "$platform"
    else
        assert_file_payload "$ROOT/shared/obs/scenes/I3_x11.json" "$home/.config/obs-studio/basic/scenes/I3_x11.json" "$home" mcsrtest "$platform"
    fi

    if [[ "$platform" == wayland && "$tier" == NL ]]; then
        printf 'user edit after install\n' >>"$home/.config/yazi/yazi.toml"
        printf 'waybar\n' >"$(<"$home/.test-state-path")/packages.added"
        HOME="$home" "$home/DoOvers/undo-waybar.sh"
        assert "$(grep -Fq 'exec = "foot-tabbed"' "$home/.config/jay/config.toml" && printf yes)" "Waybar undo preserves Jay bindings"
        assert "$(! grep -Fq 'MCSR_SETUP_WAYBAR_START' "$home/.config/jay/config.toml" && printf yes)" "Waybar undo removes only marked startup"
        assert "$(grep -Fxc 'show-bar = true' "$home/.config/jay/config.toml")" "Waybar undo restores Jay's built-in bar"
        assert "$(grep -Fq 'logo-Return' "$home/.config/jay/config.toml" && grep -Fq 'keymap.rmlvo = { layout = "gb,no"' "$home/.config/jay/config.toml" && printf yes)" "Waybar undo preserves unrelated Jay settings"
        python3 - "$ROOT/wayland/jay/NL-config.toml" "$home/.config/jay/config.toml" "$home" <<'PY'
import pathlib, sys
source, deployed, home = map(pathlib.Path, sys.argv[1:])
expected = source.read_text().replace('@HOME@', str(home))
expected = '\n'.join(
    line.replace('show-bar = false', 'show-bar = true')
    for line in expected.splitlines()
    if 'MCSR_SETUP_WAYBAR_START' not in line
) + '\n'
if deployed.read_text() != expected:
    raise SystemExit('Waybar undo changed unrelated Jay configuration')
PY
        config_path="$home/.config/jay/config.toml"
        state_dir="$(<"$home/.test-state-path")"
        expected_fingerprint="file:$(sha256sum -- "$config_path" | cut -d' ' -f1)"
        recorded_fingerprint=$(python3 - "$state_dir/files.after" "$config_path" <<'PY'
import pathlib, sys
records = pathlib.Path(sys.argv[1]).read_bytes().split(b'\0')
target = sys.argv[2].encode()
for path, fingerprint in zip(records[0::2], records[1::2]):
    if path == target:
        print(fingerprint.decode())
        break
else:
    raise SystemExit('Jay config missing from rollback fingerprints')
PY
        )
        assert "$( [[ "$recorded_fingerprint" == "$expected_fingerprint" ]] && printf yes)" "Waybar undo updates Jay rollback fingerprint"
        HOME="$home" "$home/DoOvers/undo-waybar.sh" >/dev/null
        assert "$(grep -Fxc 'show-bar = true' "$home/.config/jay/config.toml")" "repeated Waybar undo is harmless"
        assert "$(grep -Fq -- '-R --noconfirm waybar' "$MCSR_TEST_PACMAN_LOG" && printf yes)" "Waybar undo requests non-recursive package removal"
        assert "$(! grep -Fxq waybar "$(<"$home/.test-state-path")/packages.added" && printf yes)" "Waybar package rollback record updated"
        HOME="$home" "$home/DoOvers/reset.sh"
        assert "$(grep -Fxq 'pre-install foot config' "$home/.config/foot/foot.ini" && printf yes)" "rollback restores prior file"
        assert "$(grep -Fq 'user edit after install' "$home/.config/yazi/yazi.toml" && printf yes)" "rollback preserves subsequent user edit"
        assert "$(test ! -e "$home/.local/bin/yazi-edit" && printf yes)" "rollback removes unchanged installer-created helper"
        assert "$(test ! -e "$home/.config/jay/config.toml" && printf yes)" "rollback removes updated installer-created Jay config"
        assert "$(test ! -L "$home/MCSR/CrossDisplayManager/MCSRlauncher/launcher" && printf yes)" "rollback removes installer-created launcher symlink"
        assert "$(grep -Fxq '# existing login profile' "$home/.bash_profile" && ! grep -Fq MCSR_SETUP_LOCAL_BIN_PATH "$home/.bash_profile" && printf yes)" "rollback restores pre-existing Bash login profile"
    fi
    printf 'STAGED PASS: %s (home=%s)\n' "$variant" "$home"
}

stage_variant NLmcsrWL.sh wayland NL
stage_variant LmcsrWL.sh wayland L
stage_variant NLmcsrX11.sh x11 NL
launcher_conflict_home="$STAGE_ROOT/launcher-conflict/home"
launcher_conflict_dir="$launcher_conflict_home/MCSR/CrossDisplayManager/MCSRlauncher/launcher"
mkdir -p "$launcher_conflict_dir"
printf 'preserve existing runtime data\n' >"$launcher_conflict_dir/sentinel"
if ROOT="$ROOT" MCSR_PLATFORM=wayland MCSR_TIER=NL MCSR_VARIANT=NLmcsrWL.sh \
    MCSR_TARGET_USER=mcsrtest MCSR_TARGET_HOME="$launcher_conflict_home" \
    bash -c 'set -Eeuo pipefail; source "$ROOT/shared/install-common.sh"; deploy_common_configuration' \
    >"$STAGE_ROOT/launcher-conflict.log" 2>&1; then
    assert "" "physical launcher sibling runtime is rejected"
fi
assert "$(grep -Fq 'refusing to replace existing MCSRLauncher runtime directory' "$STAGE_ROOT/launcher-conflict.log" && grep -Fxq 'preserve existing runtime data' "$launcher_conflict_dir/sentinel" && printf yes)" "physical launcher runtime remains untouched on conflict"
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
