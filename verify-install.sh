#!/usr/bin/env bash
set -uo pipefail

VARIANT=${1:-NLmcsrWL.sh}
TARGET_USER=$(id -un)
TARGET_HOME=${HOME:?HOME is not set}
FAILURES=0

case "$VARIANT" in
    NLmcsrWL.sh|LmcsrWL.sh)
        PLATFORM=wayland
        INSTANCE=waywall
        OBS_SCENE=JAY_wayland.json
        ;;
    NLmcsrX11.sh|LmcsrX11.sh)
        PLATFORM=x11
        INSTANCE=MCSRRanked
        OBS_SCENE=I3_x11.json
        ;;
    *)
        printf 'FAIL unknown variant: %s\n' "$VARIANT"
        exit 2
        ;;
esac

pass() { printf 'PASS %s\n' "$*"; }
warn() { printf 'WARN %s\n' "$*"; }
fail() { printf 'FAIL %s\n' "$*"; FAILURES=$((FAILURES + 1)); }

check_file() {
    local label=$1 path=$2
    [[ -f "$path" ]] && pass "$label" || fail "$label ($path)"
}

check_dir() {
    local label=$1 path=$2
    [[ -d "$path" ]] && pass "$label" || fail "$label ($path)"
}

check_executable() {
    local label=$1 path=$2
    [[ -x "$path" ]] && pass "$label" || fail "$label ($path)"
}

check_command() {
    local label=$1 command_name=$2
    command -v "$command_name" >/dev/null 2>&1 && pass "$label" || fail "$label ($command_name)"
}

check_contains() {
    local label=$1 path=$2 text=$3
    if [[ -r "$path" ]] && grep -Fq -- "$text" "$path"; then
        pass "$label"
    else
        fail "$label"
    fi
}

check_enabled() {
    local unit=$1 state
    state=$(systemctl is-enabled "$unit" 2>/dev/null || true)
    [[ "$state" == enabled ]] && pass "$unit enabled" || fail "$unit enabled (state: ${state:-unknown})"
}

check_user_enabled() {
    local unit=$1 state
    state=$(systemctl --user is-enabled "$unit" 2>/dev/null || true)
    [[ "$state" == enabled ]] && pass "$unit user service enabled" || fail "$unit user service enabled (state: ${state:-unknown})"
}

check_mime() {
    local mime=$1 expected=$2 actual
    actual=$(xdg-mime query default "$mime" 2>/dev/null || true)
    [[ "$actual" == "$expected" ]] \
        && pass "$mime default is $expected" \
        || fail "$mime default (expected $expected, got ${actual:-none})"
}

printf 'Verifying %s for %s at %s\n' "$VARIANT" "$TARGET_USER" "$TARGET_HOME"

for command_spec in \
    'Discord:discord' \
    'Helium:helium-browser' \
    'Spotify:spotify-launcher' \
    'OBS Studio:obs' \
    'qpwgraph:qpwgraph' \
    'Shotcut:shotcut' \
    'GIMP:gimp' \
    'imv:imv' \
    'mpv:mpv' \
    'Zellij:zellij' \
    'Yazi:yazi' \
    'Thunar:thunar' \
    'Micro:micro' \
    'fd:fd' \
    'ripgrep:rg' \
    'playerctl:playerctl'; do
    check_command "${command_spec%%:*}" "${command_spec#*:}"
done

check_executable "MCSRLauncher wrapper" "$TARGET_HOME/.local/bin/mcsrlauncher"
check_file "MCSRLauncher JAR" "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar"
check_file "MCSRLauncher options" "$TARGET_HOME/launcher/options.json"
check_file "MCSRLauncher desktop entry" "$TARGET_HOME/.local/share/applications/mcsrlauncher.desktop"
check_file "Ninjabrain JAR" "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/Ninjabrain-Bot-1.5.2.jar"
check_file "Paceman JAR" "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/paceman-tracker-0.7.2.jar"

check_file "Foot config" "$TARGET_HOME/.config/foot/foot.ini"
check_file "Zellij config" "$TARGET_HOME/.config/zellij/config.kdl"
check_file "Yazi dual-pane Zellij layout" "$TARGET_HOME/.config/zellij/layouts/yazi-dual.kdl"
check_executable "Micro opener" "$TARGET_HOME/.local/bin/mcsr-open-micro"
check_executable "Yazi opener" "$TARGET_HOME/.local/bin/mcsr-open-yazi"
check_executable "OBS wrapper" "$TARGET_HOME/.local/bin/obs"

check_file "OBS profile" "$TARGET_HOME/.config/obs-studio/basic/profiles/optimized/basic.ini"
check_file "OBS global configuration" "$TARGET_HOME/.config/obs-studio/global.ini"
check_file "OBS user configuration" "$TARGET_HOME/.config/obs-studio/user.ini"
check_file "OBS scene collection" "$TARGET_HOME/.config/obs-studio/basic/scenes/$OBS_SCENE"
check_contains "OBS optimized profile selected" "$TARGET_HOME/.config/obs-studio/user.ini" 'ProfileDir=optimized'
check_contains "OBS current scene selected" "$TARGET_HOME/.config/obs-studio/user.ini" "SceneCollectionFile=${OBS_SCENE%.json}"
check_dir "OBS assets" "$TARGET_HOME/MCSR/CrossDisplayManager/obs images"
check_contains "OBS Mic/Aux noise suppression" "$TARGET_HOME/.config/obs-studio/basic/scenes/$OBS_SCENE" 'noise_suppress_filter'
check_contains "OBS Mic/Aux compressor" "$TARGET_HOME/.config/obs-studio/basic/scenes/$OBS_SCENE" 'compressor_filter'
check_contains "OBS Mic/Aux expander" "$TARGET_HOME/.config/obs-studio/basic/scenes/$OBS_SCENE" 'expander_filter'
check_contains "OBS Mic/Aux limiter" "$TARGET_HOME/.config/obs-studio/basic/scenes/$OBS_SCENE" 'limiter_filter'

check_dir "$INSTANCE Minecraft instance" "$TARGET_HOME/launcher/instances/$INSTANCE/minecraft"
check_file "$INSTANCE instance metadata" "$TARGET_HOME/launcher/instances/$INSTANCE/instance.json"
if command -v jq >/dev/null 2>&1 && [[ -r "$TARGET_HOME/launcher/instances/$INSTANCE/instance.json" ]]; then
    actual_id=$(jq -r '.id // empty' "$TARGET_HOME/launcher/instances/$INSTANCE/instance.json" 2>/dev/null || true)
    [[ "$actual_id" == "$INSTANCE" ]] && pass "$INSTANCE metadata id" || fail "$INSTANCE metadata id (got ${actual_id:-none})"
fi

check_file "keyd configuration" /etc/keyd/normal.conf
check_contains "keyd mouse2 mapping" /etc/keyd/normal.conf 'mouse2 = home'
check_contains "keyd mouse1 mapping" /etc/keyd/normal.conf 'mouse1 = backspace'
check_contains "keyd right-control desktop mapping" /etc/keyd/normal.conf 'rightcontrol = leftmeta'
check_enabled NetworkManager.service
check_enabled keyd.service
check_enabled lightdm.service
check_user_enabled pipewire.socket
check_user_enabled pipewire-pulse.socket
check_user_enabled wireplumber.service

if id -nG "$TARGET_USER" | tr ' ' '\n' | grep -Fxq input; then
    pass "user belongs to input group"
else
    fail "user belongs to input group (log out or reboot after installation)"
fi

if [[ "$PLATFORM" == wayland ]]; then
    check_command "Foot" foot
    check_executable "Jay wrapper" "$TARGET_HOME/.local/bin/jay"
    check_executable "Jay binary" "$TARGET_HOME/.local/bin/jay.real"
    check_file "Jay config" "$TARGET_HOME/.config/jay/config.toml"
    check_contains "Jay desktop keymap remains gb,no" "$TARGET_HOME/.config/jay/config.toml" 'layout = "gb,no"'
    check_file "Jay session" /usr/share/wayland-sessions/jay.desktop
    check_contains "Jay session has absolute local binary" /usr/share/wayland-sessions/jay.desktop "Exec=$TARGET_HOME/.local/bin/jay run"
    check_executable "Waywall binary" "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
    check_file "Waywall config" "$TARGET_HOME/.config/waywall/init.lua"
    check_contains "Waywall owns mcsr gameplay keymap" "$TARGET_HOME/.config/waywall/init.lua" 'layout = "mcsr"'
    check_file "MCSR XKB source" "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr"
    if [[ -L "$TARGET_HOME/.config/xkb/symbols/mcsr" ]] \
        && [[ "$(readlink -f "$TARGET_HOME/.config/xkb/symbols/mcsr")" == "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr" ]]; then
        pass "MCSR XKB live link"
    else
        fail "MCSR XKB live link"
    fi
    check_file "Jay portal metadata" /usr/share/xdg-desktop-portal/portals/jay.portal
    check_user_enabled xdg-desktop-portal-jay.service
    check_user_enabled obs-input-overlay.service
    check_file "OBS input overlay" "$TARGET_HOME/.local/share/obs-input-overlay/index.html"
    check_executable "OBS input overlay bridge" "$TARGET_HOME/.local/bin/obs-input-overlay"
    check_contains "Waywall instance uses portable local wrapper" \
        "$TARGET_HOME/launcher/instances/waywall/instance.json" \
        "$TARGET_HOME/.local/bin/waywall-ctrl-scroll wrap --"
else
    check_command "i3" i3
    check_file "i3 config" "$TARGET_HOME/.config/i3/config"
    check_dir "X11 xmodmap assets" "$TARGET_HOME/MCSR/x11/xmodmap"
fi

check_mime x-scheme-handler/http helium.desktop
check_mime x-scheme-handler/https helium.desktop
check_mime text/plain micro-foot.desktop
check_mime video/mp4 mpv.desktop
check_mime image/png imv.desktop
check_mime inode/directory yazi-foot.desktop

scan_candidates=(
    "$TARGET_HOME/.config/jay"
    "$TARGET_HOME/.config/waywall"
    "$TARGET_HOME/.config/xkb"
    "$TARGET_HOME/.config/foot"
    "$TARGET_HOME/.config/zellij"
    "$TARGET_HOME/.config/i3"
    "$TARGET_HOME/.config/obs-studio"
    "$TARGET_HOME/.config/systemd/user"
    "$TARGET_HOME/.config/environment.d"
    "$TARGET_HOME/.config/mimeapps.list"
    "$TARGET_HOME/.local/bin"
    "$TARGET_HOME/.local/share/applications"
    "$TARGET_HOME/MCSR/wayland"
    "$TARGET_HOME/MCSR/x11"
    "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher"
    "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles"
    "$TARGET_HOME/launcher/options.json"
    "$TARGET_HOME/launcher/instances/$INSTANCE/instance.json"
    "$TARGET_HOME/launcher/instances/$INSTANCE/minecraft/config"
    "$TARGET_HOME/launcher/instances/$INSTANCE/minecraft/options.txt"
    "$TARGET_HOME/launcher/instances/$INSTANCE/minecraft/mcsrranked"
)
scan_paths=()
for path in "${scan_candidates[@]}"; do
    [[ -e "$path" || -L "$path" ]] && scan_paths+=("$path")
done
if ((${#scan_paths[@]} == 0)); then
    fail "no installed runtime paths were available for portability checks"
else
    if [[ "$TARGET_USER" != nathan ]]; then
        if rg -I -l '/home/nathan' "${scan_paths[@]}" >/dev/null 2>&1; then
            fail "installed runtime files contain /home/nathan"
        else
            pass "installed runtime files contain no /home/nathan paths"
        fi
    fi
    if rg -I -l '@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' "${scan_paths[@]}" >/dev/null 2>&1; then
        fail "installed runtime files contain unrendered template markers"
    else
        pass "installed runtime templates are rendered"
    fi
fi

warn "Minecraft/Microsoft, Twitch, SoundAlerts, and GitHub authentication are intentionally manual"
warn "DP-1 1920x1080@165 and Razer DPI actions are guarded reference-hardware settings"

if ((FAILURES > 0)); then
    printf 'FAIL %d required check(s) failed\n' "$FAILURES"
    exit 1
fi

printf 'PASS all required checks passed\n'
