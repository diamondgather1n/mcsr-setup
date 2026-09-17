#!/usr/bin/env bash
set -Eeuo pipefail

: "${ROOT:?entry-point script must set ROOT}"
: "${MCSR_VARIANT:?entry-point script must set MCSR_VARIANT}"
: "${MCSR_PLATFORM:?entry-point script must set MCSR_PLATFORM}"
: "${MCSR_TIER:?entry-point script must set MCSR_TIER}"

TARGET_USER="${MCSR_TARGET_USER:-$(id -un)}"
TARGET_HOME="${MCSR_TARGET_HOME:-${HOME:?HOME is not set}}"
CURRENT_STAGE="initialization"
LOG_FILE=""
SYSTEM_ROOT="${MCSR_SYSTEM_ROOT:-}"
ROLLBACK_STATE=""
ROLLBACK_TRACKING=1
declare -gA ROLLBACK_RECORDED=()

if [[ "$MCSR_PLATFORM" == wayland ]]; then
    OBS_COLLECTION="JAY (wayland)"
    OBS_SCENE_FILE="JAY_wayland"
else
    OBS_COLLECTION="I3 (x11)"
    OBS_SCENE_FILE="I3_x11"
fi

die() {
    {
        printf '\n===== MCSR SETUP FAILED =====\n'
        printf 'Variant: %s\n' "$MCSR_VARIANT"
        printf 'Stage: %s\n' "$CURRENT_STAGE"
        printf 'Reason: %s\n' "$*"
        [[ -n "$LOG_FILE" ]] && printf 'Log: %s\n' "$LOG_FILE"
    } >&2
    exit 1
}

on_error() {
    local status=$?
    {
        printf '\n===== MCSR SETUP FAILED =====\n'
        printf 'Variant: %s\n' "$MCSR_VARIANT"
        printf 'Stage: %s\n' "$CURRENT_STAGE"
        printf 'Exit: %d\n' "$status"
        printf 'Command: %s\n' "$BASH_COMMAND"
        [[ -n "$LOG_FILE" ]] && printf 'Log: %s\n' "$LOG_FILE"
    } >&2
    exit "$status"
}
trap on_error ERR

stage() {
    CURRENT_STAGE=$1
    printf '\n==> [%s] %s\n' "$MCSR_VARIANT" "$CURRENT_STAGE"
}

read_list() {
    grep -Ev '^[[:space:]]*(#|$)' "$1"
}

java_default() {
    local value
    if value=$(archlinux-java get 2>/dev/null); then
        printf '%s\n' "$value"
    else
        printf 'none\n'
    fi
}

require_file() {
    [[ -f "$1" ]] || die "missing required source file: $1"
}

require_dir() {
    [[ -d "$1" ]] || die "missing required source directory: $1"
}

require_executable() {
    [[ -x "$1" ]] || die "missing or non-executable source file: $1"
}

root_path() {
    printf '%s%s' "$SYSTEM_ROOT" "$1"
}

setup_logging() {
    [[ "${MCSR_SETUP_LOGGING_STARTED:-0}" == 1 ]] && return
    LOG_FILE="$TARGET_HOME/mcsr-setup-$MCSR_VARIANT.log"
    touch "$LOG_FILE" || die "could not write installer log: $LOG_FILE"
    export MCSR_SETUP_LOGGING_STARTED=1
    exec > >(tee -a "$LOG_FILE") 2>&1
    printf '\n===== MCSR SETUP STARTED =====\n'
    printf 'Variant: %s\n' "$MCSR_VARIANT"
    printf 'Log: %s\n' "$LOG_FILE"
}

record_destination() {
    local path=$1 privilege=${2:-user} hint=${3:-file} parent kind metadata backup
    [[ -n "$ROLLBACK_STATE" && "$ROLLBACK_TRACKING" == 1 ]] || return 0

    parent=${path%/*}
    [[ "$parent" != "$path" ]] || parent=.
    while [[ "$parent" != / && ! -d "$parent" ]]; do
        if [[ -z "${ROLLBACK_RECORDED[$parent]+x}" ]]; then
            ROLLBACK_RECORDED[$parent]=1
            printf '%s\0%s\0%s\0' "$parent" "${privilege}:new-dir" '' >>"$ROLLBACK_STATE/files.before"
        fi
        parent=${parent%/*}
        [[ -n "$parent" ]] || parent=/
    done

    [[ -z "${ROLLBACK_RECORDED[$path]+x}" ]] || return 0
    ROLLBACK_RECORDED[$path]=1
    if [[ -L "$path" ]]; then
        kind="${privilege}:backup-link"
    elif [[ -f "$path" ]]; then
        kind="${privilege}:backup-file"
    elif [[ -d "$path" ]]; then
        [[ "$hint" == dir ]] || return 0
        metadata=$(stat -c '%u:%g:%a' -- "$path")
        printf '%s\0%s\0%s\0' "$path" "${privilege}:existing-dir" "$metadata" >>"$ROLLBACK_STATE/files.before"
        return 0
    else
        if [[ "$hint" == dir ]]; then
            kind="${privilege}:new-dir"
        else
            kind="${privilege}:new-file"
        fi
        printf '%s\0%s\0%s\0' "$path" "$kind" '' >>"$ROLLBACK_STATE/files.before"
        return 0
    fi

    metadata=$(stat -c '%u:%g:%a' -- "$path")
    backup="$ROLLBACK_STATE/files/${path#/}"
    mkdir -p -- "$(dirname -- "$backup")"
    if [[ "$privilege" == root ]]; then
        sudo cp -a -- "$path" "$backup"
        sudo chown -hR "$(id -u):$(id -g)" -- "$backup"
    else
        cp -a -- "$path" "$backup"
    fi
    printf '%s\0%s\0%s\0' "$path" "$kind" "$metadata" >>"$ROLLBACK_STATE/files.before"
}

begin_rollback_state() {
    local unit enabled active
    local state_root="$TARGET_HOME/DoOvers/state"
    stage "record pre-install rollback state"
    install -d -m 700 "$state_root"
    ROLLBACK_STATE="$state_root/$(date +%Y%m%d-%H%M%S)-$MCSR_VARIANT-$$"
    install -d -m 700 "$ROLLBACK_STATE/files"
    : >"$ROLLBACK_STATE/files.before"
    chmod 600 "$ROLLBACK_STATE/files.before"
    if [[ "${MCSR_STAGING:-0}" == 1 ]]; then
        : >"$ROLLBACK_STATE/packages.before"
    else
        pacman -Qq | LC_ALL=C sort >"$ROLLBACK_STATE/packages.before"
    fi
    chmod 600 "$ROLLBACK_STATE/packages.before"
    if [[ "${MCSR_STAGING:-0}" == 1 ]]; then
        printf '%s\n' "${MCSR_STAGE_GROUPS:-}" >"$ROLLBACK_STATE/groups.before"
    else
        id -nG "$TARGET_USER" >"$ROLLBACK_STATE/groups.before"
    fi
    chmod 600 "$ROLLBACK_STATE/groups.before"
    if command -v archlinux-java >/dev/null 2>&1; then
        java_default >"$ROLLBACK_STATE/java.before"
    else
        printf 'none\n' >"$ROLLBACK_STATE/java.before"
    fi
    chmod 600 "$ROLLBACK_STATE/java.before"

    : >"$ROLLBACK_STATE/services.before"
    if [[ "${MCSR_STAGING:-0}" == 1 ]]; then
        for unit in NetworkManager.service keyd.service lightdm.service; do
            printf 'system\0%s\0not-found\0inactive\0' "$unit" >>"$ROLLBACK_STATE/services.before"
        done
        for unit in pipewire.socket pipewire-pulse.socket wireplumber.service xdg-desktop-portal-jay.service obs-input-overlay.service; do
            printf 'user\0%s\0not-found\0inactive\0' "$unit" >>"$ROLLBACK_STATE/services.before"
        done
    else
        for unit in NetworkManager.service keyd.service lightdm.service; do
            if ! enabled=$(systemctl is-enabled "$unit" 2>/dev/null); then
                [[ -n "$enabled" ]] || enabled=not-found
            fi
            if ! active=$(systemctl is-active "$unit" 2>/dev/null); then
                [[ -n "$active" ]] || active=inactive
            fi
            printf 'system\0%s\0%s\0%s\0' "$unit" "$enabled" "$active" >>"$ROLLBACK_STATE/services.before"
        done
        for unit in pipewire.socket pipewire-pulse.socket wireplumber.service xdg-desktop-portal-jay.service obs-input-overlay.service; do
            if ! enabled=$(systemctl --user is-enabled "$unit" 2>/dev/null); then
                [[ -n "$enabled" ]] || enabled=not-found
            fi
            if ! active=$(systemctl --user is-active "$unit" 2>/dev/null); then
                [[ -n "$active" ]] || active=inactive
            fi
            printf 'user\0%s\0%s\0%s\0' "$unit" "$enabled" "$active" >>"$ROLLBACK_STATE/services.before"
        done
    fi
    chmod 600 "$ROLLBACK_STATE/services.before"
    printf '%s\n' "${ROLLBACK_STATE##*/}" >"$state_root/latest"
    chmod 600 "$state_root/latest"
}

current_fingerprint() {
    local path=$1
    if [[ -L "$path" ]]; then
        printf 'link:%s' "$(readlink -- "$path")"
    elif [[ -f "$path" ]]; then
        printf 'file:%s' "$(sha256sum -- "$path" | cut -d' ' -f1)"
    elif [[ -d "$path" ]]; then
        printf 'dir:%s' "$(stat -c '%u:%g:%a' -- "$path")"
    else
        printf 'missing'
    fi
}

finish_rollback_state() {
    local path fingerprint item i
    local -a fields
    local -a file_paths=()
    local -A fingerprints=()
    stage "save rollback actions and post-install fingerprints"
    if [[ "${MCSR_STAGING:-0}" == 1 ]]; then
        cp "$ROLLBACK_STATE/packages.before" "$ROLLBACK_STATE/packages.after"
    else
        pacman -Qq | LC_ALL=C sort >"$ROLLBACK_STATE/packages.after"
    fi
    comm -13 "$ROLLBACK_STATE/packages.before" "$ROLLBACK_STATE/packages.after" >"$ROLLBACK_STATE/packages.added"
    chmod 600 "$ROLLBACK_STATE/packages.after" "$ROLLBACK_STATE/packages.added"
    if command -v archlinux-java >/dev/null 2>&1; then
        java_default >"$ROLLBACK_STATE/java.after"
    else
        printf 'none\n' >"$ROLLBACK_STATE/java.after"
    fi
    chmod 600 "$ROLLBACK_STATE/java.after"
    : >"$ROLLBACK_STATE/files.after"
    mapfile -d '' -t fields <"$ROLLBACK_STATE/files.before"
    for ((i=0; i+2<${#fields[@]}; i+=3)); do
        path=${fields[i]}
        [[ -f "$path" && ! -L "$path" ]] && file_paths+=("$path")
    done
    if ((${#file_paths[@]} > 0)); then
        while IFS= read -r -d '' item; do
            fingerprints["${item:66}"]="file:${item:0:64}"
        done < <(printf '%s\0' "${file_paths[@]}" | xargs -0 -r sha256sum --zero --)
    fi
    for ((i=0; i+2<${#fields[@]}; i+=3)); do
        path=${fields[i]}
        if [[ -n "${fingerprints[$path]+x}" ]]; then
            fingerprint=${fingerprints[$path]}
        else
            fingerprint=$(current_fingerprint "$path")
        fi
        printf '%s\0%s\0' "$path" "$fingerprint" >>"$ROLLBACK_STATE/files.after"
    done
    chmod 600 "$ROLLBACK_STATE/files.after"
    if [[ -f "$TARGET_HOME/.config/waybar/config" && -f "$TARGET_HOME/.config/waybar/style.css" ]]; then
        sha256sum "$TARGET_HOME/.config/waybar/config" "$TARGET_HOME/.config/waybar/style.css" \
            | awk '{print $1}' >"$ROLLBACK_STATE/waybar.sha256"
        chmod 600 "$ROLLBACK_STATE/waybar.sha256"
    fi
}

file_has_template_marker() {
    grep -IqE '@(HOME|USER|OBS_COLLECTION|OBS_SCENE_FILE)@' "$1"
}

deploy_rendered() {
    local src=$1 dest=$2 mode=${3:-644} tmp
    require_file "$src"
    record_destination "$dest"
    mkdir -p "$(dirname "$dest")"
    tmp=$(mktemp)
    sed \
        -e "s|@HOME@|$TARGET_HOME|g" \
        -e "s|@USER@|$TARGET_USER|g" \
        -e "s|@OBS_COLLECTION@|$OBS_COLLECTION|g" \
        -e "s|@OBS_SCENE_FILE@|$OBS_SCENE_FILE|g" \
        "$src" >"$tmp"
    install -m "$mode" "$tmp" "$dest"
    rm -f -- "$tmp"
}

deploy_copy() {
    local src=$1 dest=$2 mode=${3:-644}
    require_file "$src"
    record_destination "$dest"
    mkdir -p "$(dirname "$dest")"
    install -m "$mode" "$src" "$dest"
}

deploy_root_rendered() {
    local src=$1 dest=$2 mode=${3:-644} tmp target
    require_file "$src"
    target=$(root_path "$dest")
    if [[ -n "$SYSTEM_ROOT" ]]; then
        record_destination "$target"
    else
        record_destination "$target" root
    fi
    tmp=$(mktemp)
    sed \
        -e "s|@HOME@|$TARGET_HOME|g" \
        -e "s|@USER@|$TARGET_USER|g" \
        -e "s|@OBS_COLLECTION@|$OBS_COLLECTION|g" \
        -e "s|@OBS_SCENE_FILE@|$OBS_SCENE_FILE|g" \
        "$src" >"$tmp"
    if [[ -n "$SYSTEM_ROOT" ]]; then
        install -Dm"$mode" "$tmp" "$target"
    else
        sudo install -Dm"$mode" "$tmp" "$target"
    fi
    rm -f -- "$tmp"
}

deploy_tree() {
    local src=$1 dest=$2 entry rel mode target
    require_dir "$src"
    record_destination "$dest" user dir
    mkdir -p "$dest"

    while IFS= read -r -d '' entry; do
        rel=${entry#"$src/"}
        case "$rel" in
            __pycache__|__pycache__/*|*/__pycache__|*/__pycache__/*|*.pyc)
                continue
                ;;
        esac
        target="$dest/$rel"
        if [[ -d "$entry" && ! -L "$entry" ]]; then
            record_destination "$target" user dir
            mkdir -p "$target"
        elif [[ -L "$entry" ]]; then
            record_destination "$target"
            mkdir -p "$(dirname "$target")"
            ln -sfn "$(readlink "$entry")" "$target"
        elif [[ -f "$entry" ]]; then
            mode=644
            [[ -x "$entry" ]] && mode=755
            if file_has_template_marker "$entry"; then
                deploy_rendered "$entry" "$target" "$mode"
            else
                deploy_copy "$entry" "$target" "$mode"
            fi
        fi
    done < <(find "$src" -mindepth 1 -print0)
}

render_instance_templates() {
    local dest=$1 file mode tmp
    while IFS= read -r -d '' file; do
        case "$file" in
            *.cfg|*.conf|*.ini|*.json|*.json5|*.kdl|*.lua|*.properties|*.sh|*.toml|*.txt|*.xml|*.yaml|*.yml) ;;
            *) continue ;;
        esac
        file_has_template_marker "$file" || continue
        mode=$(stat -c '%a' "$file")
        tmp=$(mktemp)
        sed \
            -e "s|@HOME@|$TARGET_HOME|g" \
            -e "s|@USER@|$TARGET_USER|g" \
            -e "s|@OBS_COLLECTION@|$OBS_COLLECTION|g" \
            -e "s|@OBS_SCENE_FILE@|$OBS_SCENE_FILE|g" \
            "$file" >"$tmp"
        install -m "$mode" "$tmp" "$file"
        rm -f -- "$tmp"
    done < <(find "$dest" -type f -print0)
}

jay_version_token_is_expected() {
    local output=$1 version
    read -r version _ <<<"$output"
    [[ "$version" == "1.14.0" ]]
}

validate_built_jay_version() {
    local output
    output="$("$TARGET_HOME/.local/bin/jay" version)"
    if ! jay_version_token_is_expected "$output"; then
        die "built Jay reported '$output'; expected first version token 1.14.0"
    fi
    printf 'Jay version check passed: %s\n' "$output"
}

assert_file() {
    [[ -f "$1" ]] || die "post-deploy sanity missing file: $1"
}

assert_dir() {
    [[ -d "$1" ]] || die "post-deploy sanity missing directory: $1"
}

assert_executable() {
    [[ -x "$1" ]] || die "post-deploy sanity missing executable: $1"
}

assert_contains() {
    local path=$1 text=$2
    [[ -r "$path" ]] || die "post-deploy sanity cannot read: $path"
    grep -Fq -- "$text" "$path" || die "post-deploy sanity expected '$text' in $path"
}

deploy_instance() {
    local src=$1 dest=$2 old_manifest rel entry target
    old_manifest="$dest/.mcsr-setup-manifest"
    require_dir "$src"
    record_destination "$dest" user dir
    mkdir -p "$dest"

    if [[ -f "$old_manifest" ]]; then
        while IFS= read -r rel; do
            [[ -n "$rel" && "$rel" != /* && "$rel" != *'..'* ]] || continue
            if [[ ! -e "$src/$rel" && ! -L "$src/$rel" ]]; then
                record_destination "$dest/$rel"
                rm -f -- "$dest/$rel"
            fi
        done <"$old_manifest"
    fi

    while IFS= read -r -d '' entry; do
        rel=${entry#"$src/"}
        target="$dest/$rel"
        [[ -d "$entry" && ! -L "$entry" ]] && record_destination "$target" user dir || :
        record_destination "$target"
    done < <(find "$src" -mindepth 1 -print0)
    record_destination "$old_manifest"

    if [[ "${MCSR_STAGE_HARDLINK_INSTANCES:-0}" == 1 ]]; then
        cp -al --no-clobber "$src/." "$dest/"
    else
        cp -a "$src/." "$dest/"
    fi
    render_instance_templates "$dest"
    find "$src" -type f -printf '%P\n' | LC_ALL=C sort >"$old_manifest"
}

preflight_sources() {
    local common_executables common_sources source
    common_sources=(
        "$ROOT/packages/pacman-common.txt"
        "$ROOT/packages/yay-common.txt"
        "$ROOT/shared/keyd/normal.conf"
        "$ROOT/shared/foot/foot.ini"
        "$ROOT/shared/zellij/config.kdl"
        "$ROOT/shared/zellij/layouts/yazi-dual.kdl"
        "$ROOT/shared/yazi/yazi.toml"
        "$ROOT/shared/yazi/keymap.toml"
        "$ROOT/shared/yazi/init.lua"
        "$ROOT/shared/yazi/package.toml"
        "$ROOT/shared/templates/reset.sh.in"
        "$ROOT/shared/templates/undo-waybar.sh.in"
        "$ROOT/shared/mcsr/launcher/MCSRLauncher.jar"
        "$ROOT/shared/mcsr/launcher/Ninjabrain-Bot-1.5.2.jar"
        "$ROOT/shared/mcsr/launcher/paceman-tracker-0.7.2.jar"
        "$ROOT/shared/mcsr/launcher/fix-ninbot-hotkeys.py"
        "$ROOT/shared/mcsr/launcher/options.json"
        "$ROOT/shared/applications/environment-wayland.conf"
        "$ROOT/shared/applications/mimeapps.list"
        "$ROOT/shared/applications/desktop/com.obsproject.Studio.desktop"
        "$ROOT/shared/applications/desktop/foot.desktop"
        "$ROOT/shared/applications/desktop/imv.desktop"
        "$ROOT/shared/applications/desktop/mcsrlauncher.desktop"
        "$ROOT/shared/applications/desktop/micro-foot.desktop"
        "$ROOT/shared/applications/desktop/yazi-foot.desktop"
        "$ROOT/shared/obs/assets/DSCN0453.png"
        "$ROOT/shared/obs/assets/background.jpg"
        "$ROOT/shared/obs/assets/heidi2.png"
        "$ROOT/shared/obs/assets/heidi3.png"
        "$ROOT/shared/obs/assets/overlay_2.webp"
        "$ROOT/shared/obs/profiles/basic.ini"
        "$ROOT/shared/obs/profiles/recordEncoder.json"
        "$ROOT/shared/obs/profiles/streamEncoder.json"
        "$ROOT/shared/obs/global.ini"
        "$ROOT/shared/obs/user.ini"
        "$ROOT/shared/polychromatic/PKGBUILD.pinned"
    )
    common_executables=(
        "$ROOT/shared/polychromatic/install.sh"
        "$ROOT/shared/scripts/mcsr-open-micro"
        "$ROOT/shared/scripts/mcsr-open-yazi"
        "$ROOT/shared/scripts/mcsr-razer-dpi"
        "$ROOT/shared/scripts/mcsrlauncher"
        "$ROOT/shared/scripts/ninjabrain"
        "$ROOT/shared/scripts/obs"
        "$ROOT/shared/scripts/spotify"
        "$ROOT/shared/scripts/yazi-edit"
        "$ROOT/shared/scripts/yazi-edit-right"
        "$ROOT/shared/scripts/yazi-archive-create"
        "$ROOT/shared/scripts/yazi-archive-extract"
    )
    for source in "${common_sources[@]}"; do
        require_file "$source"
    done
    for source in "${common_executables[@]}"; do
        require_executable "$source"
    done
    require_dir "$ROOT/shared/scripts"
    require_dir "$ROOT/shared/yazi/plugins/file-clipboard.yazi"
    require_dir "$ROOT/shared/yazi/plugins/smart-enter.yazi"
    require_dir "$ROOT/shared/yazi/plugins/ucp.yazi"
    require_dir "$ROOT/shared/applications/desktop"
    require_dir "$ROOT/shared/obs/assets"
    require_dir "$ROOT/shared/polychromatic/source"

    case "$MCSR_PLATFORM" in
        wayland)
            require_file "$ROOT/packages/pacman-wayland.txt"
            require_file "$ROOT/packages/yay-wayland.txt"
            require_file "$ROOT/wayland/jay/source/Cargo.toml"
            require_file "$ROOT/wayland/jay/source/Cargo.lock"
            require_file "$ROOT/wayland/jay/source/etc/jay.desktop"
            require_file "$ROOT/wayland/jay/source/etc/jay.portal"
            require_file "$ROOT/wayland/jay/source/etc/jay-portals.conf"
            require_file "$ROOT/wayland/jay/xdg-desktop-portal-jay.service"
            require_file "$ROOT/wayland/jay/NL-config.toml"
            require_file "$ROOT/wayland/jay/L-config.toml"
            require_file "$ROOT/wayland/helpers/jay"
            require_file "$ROOT/wayland/helpers/foot-tabbed"
            require_file "$ROOT/wayland/helpers/jay-desktop-launcher"
            require_file "$ROOT/wayland/waybar/config"
            require_file "$ROOT/wayland/waybar/style.css"
            require_file "$ROOT/wayland/waywall/NL-init.lua"
            require_file "$ROOT/wayland/waywall/L-init.lua"
            require_file "$ROOT/wayland/waywall/ctrl-scroll-actions.patch"
            require_file "$ROOT/wayland/waywall/source/Makefile"
            require_file "$ROOT/wayland/shims/jay-gbm-implicit-modifier.c"
            require_file "$ROOT/wayland/shims/obs-jay-portal-cursor.c"
            require_file "$ROOT/wayland/xkb/symbols/mcsr"
            require_file "$ROOT/shared/minecraft/instances/waywall/instance.json"
            require_file "$ROOT/shared/obs/scenes/JAY_wayland.json"
            require_file "$ROOT/shared/obs/input-overlay/index.html"
            require_file "$ROOT/shared/obs/input-overlay/overlay.css"
            require_file "$ROOT/shared/obs/input-overlay/overlay.js"
            require_file "$ROOT/shared/obs/input-overlay/obs-input-overlay"
            require_file "$ROOT/shared/obs/input-overlay/obs-input-overlay.service"
            require_executable "$ROOT/wayland/helpers/jay"
            require_executable "$ROOT/wayland/helpers/foot-tabbed"
            require_executable "$ROOT/wayland/helpers/jay-desktop-launcher"
            require_executable "$ROOT/wayland/waywall/resources/set-dpi.py"
            require_executable "$ROOT/shared/obs/input-overlay/obs-input-overlay"
            require_dir "$ROOT/wayland/waywall/resources"
            require_dir "$ROOT/wayland/waywall/source"
            require_dir "$ROOT/shared/obs/input-overlay"
            require_dir "$ROOT/shared/minecraft/instances/waywall/minecraft"
            ;;
        x11)
            require_file "$ROOT/packages/pacman-x11.txt"
            require_file "$ROOT/packages/yay-x11.txt"
            require_file "$ROOT/x11/i3/NL-config"
            require_file "$ROOT/x11/i3/L-config"
            require_file "$ROOT/shared/minecraft/instances/MCSRRanked/instance.json"
            require_file "$ROOT/shared/obs/scenes/I3_x11.json"
            require_dir "$ROOT/x11/xmodmap"
            require_dir "$ROOT/x11/macros"
            require_dir "$ROOT/x11/shell-scripts"
            require_dir "$ROOT/shared/minecraft/instances/MCSRRanked/minecraft"
            ;;
        *)
            die "unknown platform: $MCSR_PLATFORM"
            ;;
    esac

    if [[ "$MCSR_TIER" == L ]]; then
        require_file "$ROOT/packages/pacman-${MCSR_PLATFORM}-full.txt"
        require_file "$ROOT/packages/yay-${MCSR_PLATFORM}-full.txt"
        require_file "$ROOT/x11/i3blocks/config"
        require_dir "$ROOT/x11/helpers"
        if [[ "$MCSR_PLATFORM" == wayland ]]; then
            require_executable "$ROOT/wayland/helpers/input-recorder"
            require_executable "$ROOT/wayland/helpers/jay-startup-windows"
        fi
    fi

    if find "$ROOT" -path "$ROOT/.git" -prune -o -type f \
        \( -name accounts.json -o -name service.json \) -print -quit | grep -q .; then
        die "launcher or OBS authentication data is present in the repository"
    fi
}

preflight() {
    local available_kb expected_home payload_kb required_kb
    stage "preflight"
    printf 'Selected variant: %s (%s, %s)\n' "$MCSR_VARIANT" "$MCSR_TIER" "$MCSR_PLATFORM"
    printf 'Target user: %s\nTarget home: %s\n' "$TARGET_USER" "$TARGET_HOME"

    [[ "$TARGET_USER" != root && "$EUID" -ne 0 ]] || die "run as a normal user, not root"
    [[ "$TARGET_USER" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]] || die "unsupported user name: $TARGET_USER"
    [[ "$TARGET_HOME" =~ ^/[A-Za-z0-9._/-]+$ ]] || die "unsupported home path: $TARGET_HOME"
    expected_home=$(getent passwd "$TARGET_USER" | cut -d: -f6)
    [[ -n "$expected_home" && "$TARGET_HOME" == "$expected_home" ]] \
        || die "HOME does not match the account home ($expected_home)"
    [[ -d "$TARGET_HOME" && -w "$TARGET_HOME" ]] || die "target home is not writable"
    [[ -f /etc/arch-release ]] || die "this installer requires Arch Linux"
    command -v pacman >/dev/null || die "pacman is required"
    command -v sudo >/dev/null || die "sudo is required"
    command -v git >/dev/null || die "git is required"
    command -v makepkg >/dev/null || die "makepkg is required"
    command -v curl >/dev/null || die "curl is required"
    [[ -d "$ROOT/.git" ]] || die "run this installer from a Git clone"
    sudo -v
    systemctl --user show-environment >/dev/null \
        || die "a systemd user manager is required for user services"

    preflight_sources

    if [[ "$MCSR_PLATFORM" == wayland ]]; then
        payload_kb=$(du -sk "$ROOT/shared/minecraft/instances/waywall" | awk '{print $1}')
    else
        payload_kb=$(du -sk "$ROOT/shared/minecraft/instances/MCSRRanked" | awk '{print $1}')
    fi
    available_kb=$(df --output=avail "$TARGET_HOME" | tail -n 1)
    [[ "$available_kb" =~ ^[[:space:]]*[0-9]+[[:space:]]*$ ]] || die "could not determine free disk space"
    required_kb=$((payload_kb + 6 * 1024 * 1024))
    (( available_kb >= required_kb )) || die "insufficient free space: need the instance payload plus 6 GiB"

    curl -fsSI --connect-timeout 10 --max-time 20 https://archlinux.org/ >/dev/null
    git ls-remote https://aur.archlinux.org/yay.git HEAD >/dev/null
}

detect_hardware_packages() {
    local packages=() vendor
    if grep -q 'vendor_id[[:space:]]*: AuthenticAMD' /proc/cpuinfo; then
        packages+=(amd-ucode)
    elif grep -q 'vendor_id[[:space:]]*: GenuineIntel' /proc/cpuinfo; then
        packages+=(intel-ucode)
    fi

    shopt -s nullglob
    for vendor in /sys/class/drm/card*/device/vendor; do
        case "$(<"$vendor")" in
            0x1002) packages+=(vulkan-radeon); break ;;
            0x8086) packages+=(vulkan-intel); break ;;
        esac
    done
    shopt -u nullglob
    if ((${#packages[@]} > 0)); then
        printf '%s\n' "${packages[@]}"
    fi
}

install_pacman_packages() {
    local packages=() list
    local -a hardware_packages list_packages
    stage "official Arch packages"
    for list in "$ROOT/packages/pacman-common.txt" "$ROOT/packages/pacman-${MCSR_PLATFORM}.txt"; do
        mapfile -t list_packages < <(read_list "$list")
        packages+=("${list_packages[@]}")
    done
    if [[ "$MCSR_TIER" == L ]]; then
        mapfile -t list_packages < <(read_list "$ROOT/packages/pacman-${MCSR_PLATFORM}-full.txt")
        packages+=("${list_packages[@]}")
    fi
    mapfile -t hardware_packages < <(detect_hardware_packages)
    packages+=("${hardware_packages[@]}")
    sudo pacman -Syu --needed --noconfirm "${packages[@]}"
}

ensure_yay() {
    command -v yay >/dev/null 2>&1 && return
    (
        local build_dir
        build_dir=$(mktemp -d)
        trap 'rm -rf -- "$build_dir"' EXIT
        git clone --depth=1 https://aur.archlinux.org/yay.git "$build_dir/yay"
        cd "$build_dir/yay"
        makepkg -si --needed --noconfirm
    )
}

install_aur_packages() {
    local packages=() list
    local -a lists
    local -a list_packages
    stage "required AUR packages"
    ensure_yay
    lists=("$ROOT/packages/yay-common.txt" "$ROOT/packages/yay-${MCSR_PLATFORM}.txt")
    if [[ "$MCSR_TIER" == L ]]; then
        lists+=("$ROOT/packages/yay-${MCSR_PLATFORM}-full.txt")
    fi
    for list in "${lists[@]}"; do
        mapfile -t list_packages < <(read_list "$list")
        packages+=("${list_packages[@]}")
    done
    ((${#packages[@]} == 0)) || yay -S --needed --noconfirm "${packages[@]}"
}

build_wayland_components() {
    stage "pinned Jay, Waywall, and compatibility shims"
    command -v cargo >/dev/null || die "cargo is missing after package installation"
    command -v meson >/dev/null || die "meson is missing after Waywall package installation"
    command -v pkg-config >/dev/null || die "pkg-config is required for the OBS shim"

    (
        local build_dir install_root
        local -a gio_flags
        build_dir=$(mktemp -d)
        trap 'rm -rf -- "$build_dir"' EXIT
        install_root="$build_dir/jay-install"
        CARGO_TARGET_DIR="$build_dir/jay-target" cargo install \
            --path "$ROOT/wayland/jay/source" --locked --root "$install_root"
        record_destination "$TARGET_HOME/.local/bin/jay.real"
        install -Dm755 "$install_root/bin/jay" "$TARGET_HOME/.local/bin/jay.real"

        cc -shared -fPIC -O2 \
            -o "$build_dir/jay-gbm-implicit-modifier.so" \
            "$ROOT/wayland/shims/jay-gbm-implicit-modifier.c" -ldl -lgbm
        record_destination "$TARGET_HOME/.local/lib/jay-gbm-implicit-modifier.so"
        install -Dm755 "$build_dir/jay-gbm-implicit-modifier.so" \
            "$TARGET_HOME/.local/lib/jay-gbm-implicit-modifier.so"

        read -r -a gio_flags <<<"$(pkg-config --cflags --libs gio-2.0)"
        cc -shared -fPIC -O2 \
            -o "$build_dir/obs-jay-portal-cursor.so" \
            "$ROOT/wayland/shims/obs-jay-portal-cursor.c" -ldl "${gio_flags[@]}"
        record_destination "$TARGET_HOME/.local/lib/obs-jay-portal-cursor.so"
        install -Dm755 "$build_dir/obs-jay-portal-cursor.so" \
            "$TARGET_HOME/.local/lib/obs-jay-portal-cursor.so"

        cp -a "$ROOT/wayland/waywall/source" "$build_dir/waywall"
        patch -d "$build_dir/waywall" -p1 <"$ROOT/wayland/waywall/ctrl-scroll-actions.patch"
        make -C "$build_dir/waywall" -j"$(nproc)"
        record_destination "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
        install -Dm755 "$build_dir/waywall/build/waywall/waywall" \
            "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
    )

    deploy_copy "$ROOT/wayland/shims/jay-gbm-implicit-modifier.c" \
        "$TARGET_HOME/.local/src/jay-gbm-implicit-modifier.c"
    deploy_copy "$ROOT/wayland/shims/obs-jay-portal-cursor.c" \
        "$TARGET_HOME/.local/src/obs-jay-portal-cursor.c"
    deploy_rendered "$ROOT/wayland/helpers/jay" "$TARGET_HOME/.local/bin/jay" 755
    validate_built_jay_version
}

deploy_common_configuration() {
    local file
    stage "shared user configuration"
    deploy_tree "$ROOT/shared/scripts" "$TARGET_HOME/.local/bin"
    for file in "$ROOT/shared/applications/desktop/"*.desktop; do
        [[ "$MCSR_PLATFORM" == wayland || "$(basename "$file")" != foot.desktop ]] || continue
        deploy_rendered "$file" "$TARGET_HOME/.local/share/applications/$(basename "$file")"
    done
    if [[ "$MCSR_PLATFORM" == x11 ]]; then
        record_destination "$TARGET_HOME/.local/share/applications/foot.desktop"
        rm -f -- "$TARGET_HOME/.local/share/applications/foot.desktop"
    fi
    deploy_tree "$ROOT/shared/zellij" "$TARGET_HOME/.config/zellij"
    deploy_rendered "$ROOT/shared/foot/foot.ini" "$TARGET_HOME/.config/foot/foot.ini"
    deploy_tree "$ROOT/shared/yazi" "$TARGET_HOME/.config/yazi"
    deploy_rendered "$ROOT/shared/applications/mimeapps.list" "$TARGET_HOME/.config/mimeapps.list"

    deploy_root_rendered "$ROOT/shared/keyd/normal.conf" /etc/keyd/normal.conf

    record_destination "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher" user dir
    record_destination "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles" user dir
    record_destination "$TARGET_HOME/launcher" user dir
    mkdir -p \
        "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher" \
        "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles" \
        "$TARGET_HOME/launcher"
    deploy_copy "$ROOT/shared/mcsr/launcher/MCSRLauncher.jar" \
        "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar"
    deploy_rendered "$ROOT/shared/mcsr/launcher/options.json" "$TARGET_HOME/launcher/options.json"
    for file in Ninjabrain-Bot-1.5.2.jar paceman-tracker-0.7.2.jar; do
        deploy_copy "$ROOT/shared/mcsr/launcher/$file" \
            "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/$file"
    done
    deploy_copy "$ROOT/shared/mcsr/launcher/fix-ninbot-hotkeys.py" \
        "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/fix-ninbot-hotkeys.py" 755

    deploy_tree "$ROOT/shared/obs/assets" "$TARGET_HOME/MCSR/CrossDisplayManager/obs images"
    deploy_rendered "$ROOT/shared/obs/global.ini" "$TARGET_HOME/.config/obs-studio/global.ini"
    deploy_rendered "$ROOT/shared/obs/user.ini" "$TARGET_HOME/.config/obs-studio/user.ini"
    for file in basic.ini recordEncoder.json streamEncoder.json; do
        deploy_rendered "$ROOT/shared/obs/profiles/$file" \
            "$TARGET_HOME/.config/obs-studio/basic/profiles/optimized/$file"
    done

    if command -v update-desktop-database >/dev/null; then
        record_destination "$TARGET_HOME/.local/share/applications/mimeinfo.cache"
        update-desktop-database "$TARGET_HOME/.local/share/applications"
    fi
}

deploy_wayland_configuration() {
    local jay_config waywall_config file
    stage "Wayland desktop and MCSR configuration"
    jay_config="$ROOT/wayland/jay/${MCSR_TIER}-config.toml"
    waywall_config="$ROOT/wayland/waywall/${MCSR_TIER}-init.lua"

    deploy_rendered "$jay_config" "$TARGET_HOME/.config/jay/config.toml"
    deploy_rendered "$waywall_config" "$TARGET_HOME/.config/waywall/init.lua"
    deploy_tree "$ROOT/wayland/waywall/resources" "$TARGET_HOME/.config/waywall/resources"
    deploy_rendered "$ROOT/wayland/xkb/symbols/mcsr" "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr"
    record_destination "$TARGET_HOME/.config/xkb/symbols" user dir
    mkdir -p "$TARGET_HOME/.config/xkb/symbols"
    record_destination "$TARGET_HOME/.config/xkb/symbols/mcsr"
    ln -sfn "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr" "$TARGET_HOME/.config/xkb/symbols/mcsr"

    for file in foot-tabbed jay-desktop-launcher; do
        deploy_rendered "$ROOT/wayland/helpers/$file" "$TARGET_HOME/.local/bin/$file" 755
    done
    if [[ "$MCSR_TIER" == NL ]]; then
        deploy_rendered "$ROOT/wayland/waybar/config" "$TARGET_HOME/.config/waybar/config"
        deploy_rendered "$ROOT/wayland/waybar/style.css" "$TARGET_HOME/.config/waybar/style.css"
    fi
    if [[ "$MCSR_TIER" == L ]]; then
        for file in "$ROOT/wayland/helpers/"*; do
            [[ -f "$file" ]] && deploy_rendered "$file" "$TARGET_HOME/.local/bin/$(basename "$file")" 755
        done
        deploy_rendered "$ROOT/x11/i3blocks/config" "$TARGET_HOME/.config/i3blocks/config"
        for file in "$ROOT/x11/helpers/bar-"*; do
            deploy_rendered "$file" "$TARGET_HOME/.local/bin/$(basename "$file")" 755
        done
    fi

    deploy_root_rendered "$ROOT/wayland/jay/source/etc/jay.desktop" /usr/share/wayland-sessions/jay.desktop
    deploy_root_rendered "$ROOT/wayland/jay/source/etc/jay.portal" /usr/share/xdg-desktop-portal/portals/jay.portal
    deploy_root_rendered "$ROOT/wayland/jay/source/etc/jay-portals.conf" /usr/share/xdg-desktop-portal/jay-portals.conf
    deploy_rendered "$ROOT/wayland/jay/xdg-desktop-portal-jay.service" \
        "$TARGET_HOME/.config/systemd/user/xdg-desktop-portal-jay.service"

    deploy_instance "$ROOT/shared/minecraft/instances/waywall" "$TARGET_HOME/launcher/instances/waywall"
    deploy_rendered "$ROOT/shared/obs/scenes/JAY_wayland.json" \
        "$TARGET_HOME/.config/obs-studio/basic/scenes/JAY_wayland.json"
    for file in index.html overlay.css overlay.js; do
        deploy_rendered "$ROOT/shared/obs/input-overlay/$file" \
            "$TARGET_HOME/.local/share/obs-input-overlay/$file"
    done
    deploy_rendered "$ROOT/shared/obs/input-overlay/obs-input-overlay" \
        "$TARGET_HOME/.local/bin/obs-input-overlay" 755
    deploy_rendered "$ROOT/shared/obs/input-overlay/obs-input-overlay.service" \
        "$TARGET_HOME/.config/systemd/user/obs-input-overlay.service"
    deploy_rendered "$ROOT/shared/applications/environment-wayland.conf" \
        "$TARGET_HOME/.config/environment.d/10-mcsr-defaults.conf"

    if [[ "${MCSR_STAGING:-0}" != 1 ]]; then
        systemctl --user daemon-reload
        systemctl --user enable xdg-desktop-portal-jay.service obs-input-overlay.service
    fi
}

deploy_x11_configuration() {
    local file
    stage "X11 desktop and MCSR configuration"
    deploy_rendered "$ROOT/x11/i3/${MCSR_TIER}-config" "$TARGET_HOME/.config/i3/config"
    deploy_rendered "$ROOT/shared/zellij/config-x11.kdl" "$TARGET_HOME/.config/zellij/config-x11.kdl"
    deploy_tree "$ROOT/x11/xmodmap" "$TARGET_HOME/MCSR/x11/xmodmap"
    deploy_tree "$ROOT/x11/macros" "$TARGET_HOME/MCSR/x11/macros"
    deploy_tree "$ROOT/x11/shell-scripts" "$TARGET_HOME/MCSR/x11/shell-scripts"
    if [[ "$MCSR_TIER" == L ]]; then
        deploy_rendered "$ROOT/x11/i3blocks/config" "$TARGET_HOME/.config/i3blocks/config"
        for file in "$ROOT/x11/helpers/"*; do
            deploy_rendered "$file" "$TARGET_HOME/.local/bin/$(basename "$file")" 755
        done
    fi

    deploy_instance "$ROOT/shared/minecraft/instances/MCSRRanked" "$TARGET_HOME/launcher/instances/MCSRRanked"
    deploy_rendered "$ROOT/shared/obs/scenes/I3_x11.json" \
        "$TARGET_HOME/.config/obs-studio/basic/scenes/I3_x11.json"
}

enable_system_services() {
    stage "required services"
    if [[ "${MCSR_STAGING:-0}" == 1 ]]; then
        printf 'Staging mode: service and group state was not changed.\n'
        return
    fi
    sudo usermod -aG input "$TARGET_USER"
    if getent group plugdev >/dev/null; then
        sudo usermod -aG plugdev "$TARGET_USER"
    fi
    systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
    sudo systemctl enable NetworkManager.service lightdm.service
    sudo systemctl enable --now keyd.service
    systemctl is-enabled --quiet keyd.service || die "keyd.service is not enabled"
    systemctl is-active --quiet keyd.service || die "keyd.service failed to start"
}

post_deploy_sanity_check() {
    local mimeapps="$TARGET_HOME/.config/mimeapps.list"
    stage "pre-reboot deployment sanity check"
    assert_executable "$TARGET_HOME/.local/bin/mcsr-open-micro"
    assert_executable "$TARGET_HOME/.local/bin/mcsr-open-yazi"
    assert_executable "$TARGET_HOME/.local/bin/mcsrlauncher"
    assert_executable "$TARGET_HOME/.local/bin/ninjabrain"
    assert_executable "$TARGET_HOME/.local/bin/obs"
    assert_executable "$TARGET_HOME/.local/bin/spotify"
    assert_file "$TARGET_HOME/.config/foot/foot.ini"
    assert_file "$TARGET_HOME/.config/zellij/config.kdl"
    assert_dir "$TARGET_HOME/.config/zellij/layouts"
    assert_file "$TARGET_HOME/.config/zellij/layouts/yazi-dual.kdl"
    assert_file "$TARGET_HOME/.config/yazi/yazi.toml"
    assert_file "$TARGET_HOME/.config/yazi/keymap.toml"
    assert_file "$TARGET_HOME/.config/yazi/init.lua"
    assert_file "$TARGET_HOME/.config/yazi/package.toml"
    assert_file "$TARGET_HOME/.config/yazi/plugins/file-clipboard.yazi/main.lua"
    assert_file "$TARGET_HOME/.config/yazi/plugins/smart-enter.yazi/main.lua"
    assert_file "$TARGET_HOME/.config/yazi/plugins/ucp.yazi/main.lua"
    for helper in yazi-edit yazi-edit-right yazi-archive-create yazi-archive-extract; do
        assert_executable "$TARGET_HOME/.local/bin/$helper"
    done
    assert_file "$TARGET_HOME/.config/mimeapps.list"
    for entry in 'text/plain=micro-foot.desktop' 'image/png=imv.desktop' \
        'image/jpeg=imv.desktop' 'image/gif=imv.desktop' 'video/mp4=mpv.desktop' \
        'audio/mpeg=mpv.desktop' 'text/html=helium.desktop' 'application/pdf=helium.desktop'; do
        assert_contains "$mimeapps" "$entry"
    done
    assert_file "$TARGET_HOME/.config/obs-studio/global.ini"
    assert_file "$TARGET_HOME/.config/obs-studio/user.ini"
    assert_dir "$TARGET_HOME/.config/obs-studio/basic/profiles/optimized"
    assert_file "$(root_path /etc/keyd/normal.conf)"
    assert_contains "$(root_path /etc/keyd/normal.conf)" 'mouse2 = home'
    assert_contains "$(root_path /etc/keyd/normal.conf)" 'mouse1 = backspace'
    assert_contains "$(root_path /etc/keyd/normal.conf)" 'rightcontrol = layer(meta)'
    if [[ "${MCSR_STAGING:-0}" != 1 ]]; then
        systemctl is-enabled --quiet keyd.service || die "keyd.service is not enabled after deployment"
        systemctl is-active --quiet keyd.service || die "keyd.service is not active after deployment"
    fi
    assert_file "$TARGET_HOME/launcher/options.json"
    assert_file "$TARGET_HOME/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar"
    assert_file "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/Ninjabrain-Bot-1.5.2.jar"
    assert_file "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles/paceman-tracker-0.7.2.jar"
    assert_dir "$TARGET_HOME/MCSR/CrossDisplayManager/jarfiles"
    assert_dir "$TARGET_HOME/MCSR/CrossDisplayManager/obs images"
    for asset in DSCN0453.png background.jpg heidi2.png heidi3.png overlay_2.webp; do
        assert_file "$TARGET_HOME/MCSR/CrossDisplayManager/obs images/$asset"
    done
    assert_dir "$TARGET_HOME/.local/share/applications"
    for desktop in com.obsproject.Studio.desktop imv.desktop mcsrlauncher.desktop \
        micro-foot.desktop yazi-foot.desktop; do
        assert_file "$TARGET_HOME/.local/share/applications/$desktop"
    done
    python3 - "$TARGET_HOME/.config/yazi/yazi.toml" <<'PY'
import sys
import tomllib

with open(sys.argv[1], "rb") as source:
    tomllib.load(source)
PY

    if [[ "$MCSR_PLATFORM" == wayland ]]; then
        assert_executable "$TARGET_HOME/.local/bin/jay"
        assert_executable "$TARGET_HOME/.local/bin/jay.real"
        assert_executable "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
        assert_executable "$TARGET_HOME/.local/bin/foot-tabbed"
        assert_executable "$TARGET_HOME/.local/bin/jay-desktop-launcher"
        assert_file "$TARGET_HOME/.config/jay/config.toml"
        python3 - "$TARGET_HOME/.config/jay/config.toml" <<'PY'
import sys
import tomllib

with open(sys.argv[1], "rb") as source:
    tomllib.load(source)
PY
        assert_contains "$TARGET_HOME/.config/jay/config.toml" 'layout = "gb,no"'
        assert_contains "$TARGET_HOME/.config/jay/config.toml" 'exec = "foot-tabbed"'
        assert_contains "$TARGET_HOME/.config/zellij/config.kdl" 'ToggleMouseMode'
        assert_file "$TARGET_HOME/.config/waywall/init.lua"
        assert_contains "$TARGET_HOME/.config/waywall/init.lua" 'layout = "mcsr"'
        assert_dir "$TARGET_HOME/.config/waywall/resources"
        for file in background.png crosshair.png overlay_tall.png overlay_thin.png \
            overlay_wide.png measuring_overlay.png stretched_overlay.png set-dpi.py \
            Ninjabrain-Bot-1.5.2.jar paceman-tracker-0.7.2.jar fix-ninbot-hotkeys.py; do
            assert_file "$TARGET_HOME/.config/waywall/resources/$file"
        done
        assert_file "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr"
        [[ -L "$TARGET_HOME/.config/xkb/symbols/mcsr" ]] \
            || die "post-deploy sanity missing symlink: $TARGET_HOME/.config/xkb/symbols/mcsr"
        [[ "$(readlink -f "$TARGET_HOME/.config/xkb/symbols/mcsr")" == "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr" ]] \
            || die "post-deploy sanity bad XKB symlink target: $TARGET_HOME/.config/xkb/symbols/mcsr"
        assert_file "$TARGET_HOME/.config/obs-studio/basic/scenes/JAY_wayland.json"
        assert_file "$TARGET_HOME/.config/systemd/user/xdg-desktop-portal-jay.service"
        assert_file "$TARGET_HOME/.config/systemd/user/obs-input-overlay.service"
        assert_file "$TARGET_HOME/.config/environment.d/10-mcsr-defaults.conf"
        assert_dir "$TARGET_HOME/.local/share/obs-input-overlay"
        assert_file "$TARGET_HOME/.local/share/obs-input-overlay/index.html"
        assert_file "$TARGET_HOME/launcher/instances/waywall/instance.json"
        assert_dir "$TARGET_HOME/launcher/instances/waywall/minecraft"
        assert_contains "$TARGET_HOME/launcher/instances/waywall/instance.json" \
            '"javaPath": "/usr/lib/jvm/java-21-openjdk/bin/java"'
        assert_contains "$TARGET_HOME/launcher/instances/waywall/instance.json" \
            "$TARGET_HOME/.local/bin/waywall-ctrl-scroll wrap --"
        [[ "$(jq -r '.id' "$TARGET_HOME/launcher/instances/waywall/instance.json")" == waywall ]] \
            || die "Wayland launcher instance id is not waywall"
        assert_file "$(root_path /usr/share/wayland-sessions/jay.desktop)"
        assert_contains "$(root_path /usr/share/wayland-sessions/jay.desktop)" "Exec=$TARGET_HOME/.local/bin/jay run"
        assert_file "$(root_path /usr/share/xdg-desktop-portal/portals/jay.portal)"
        assert_file "$(root_path /usr/share/xdg-desktop-portal/jay-portals.conf)"
        if [[ "$MCSR_TIER" == NL ]]; then
            assert_file "$TARGET_HOME/.config/waybar/config"
            assert_file "$TARGET_HOME/.config/waybar/style.css"
            assert_contains "$TARGET_HOME/.config/jay/config.toml" 'MCSR_SETUP_WAYBAR_START'
            assert_contains "$TARGET_HOME/.config/jay/config.toml" 'exec = ["waybar"]'
        fi
    else
        assert_file "$TARGET_HOME/.config/i3/config"
        assert_dir "$TARGET_HOME/MCSR/x11/xmodmap"
        assert_file "$TARGET_HOME/.config/obs-studio/basic/scenes/I3_x11.json"
        assert_file "$TARGET_HOME/launcher/instances/MCSRRanked/instance.json"
        assert_dir "$TARGET_HOME/launcher/instances/MCSRRanked/minecraft"
        [[ "$(jq -r '.id' "$TARGET_HOME/launcher/instances/MCSRRanked/instance.json")" == MCSRRanked ]] \
            || die "X11 launcher instance id is not MCSRRanked"
        assert_contains "$TARGET_HOME/launcher/instances/MCSRRanked/instance.json" \
            '"javaPath": "/usr/lib/jvm/java-21-openjdk/bin/java"'
    fi

    if [[ "$MCSR_TIER" == L ]]; then
        assert_file "$TARGET_HOME/.config/i3blocks/config"
        for helper in bar-cpu bar-gpu bar-net bar-volume; do
            assert_executable "$TARGET_HOME/.local/bin/$helper"
        done
        assert_executable "$TARGET_HOME/.local/bin/input-recorder"
    fi
}

create_dovers_artifacts() {
    local dovers="$TARGET_HOME/DoOvers"
    stage "persistent verifier and rollback tools"
    mkdir -p "$dovers"
    chmod 700 "$dovers/state"
    record_destination "$dovers/reset.sh"
    record_destination "$dovers/verify-install.sh"
    if [[ "$MCSR_PLATFORM" == wayland && "$MCSR_TIER" == NL ]]; then
        record_destination "$dovers/undo-waybar.sh"
    fi
    ROLLBACK_TRACKING=0
    deploy_rendered "$ROOT/shared/templates/reset.sh.in" "$dovers/reset.sh" 755
    deploy_copy "$ROOT/verify-install.sh" "$dovers/verify-install.sh" 755
    if [[ "$MCSR_PLATFORM" == wayland && "$MCSR_TIER" == NL ]]; then
        deploy_rendered "$ROOT/shared/templates/undo-waybar.sh.in" "$dovers/undo-waybar.sh" 755
    fi
    ROLLBACK_TRACKING=1
}

safe_cleanup_checkout() {
    local checkout expected
    if [[ "${MCSR_STAGING:-0}" == 1 || "${MCSR_KEEP_CHECKOUT:-0}" == 1 ]]; then
        printf 'Checkout cleanup skipped by staging/keep-checkout setting.\n'
        return
    fi

    checkout=$(realpath -e -- "$ROOT") || die "cannot resolve installer checkout"
    expected=$(realpath -m -- "$TARGET_HOME/mcsr-setup")
    [[ ! -L "$ROOT" && ! -L "$ROOT/.git" && ! -L "$TARGET_HOME/mcsr-setup" ]] \
        || die "refusing cleanup through a symlinked checkout or .git marker"
    [[ "$checkout" == "$expected" ]] \
        || die "refusing successful completion because checkout is not exactly $TARGET_HOME/mcsr-setup"
    [[ "$checkout" != / && "$checkout" != "$TARGET_HOME" && -d "$checkout/.git" \
        && -f "$checkout/NLmcsrWL.sh" && -f "$checkout/shared/install-common.sh" ]] \
        || die "refusing to remove a checkout without expected repository markers"

    printf 'Removing verified installer checkout after copying persistent recovery tools.\n'
    rm -rf -- "$checkout"
    [[ ! -e "$checkout" && ! -L "$checkout" ]] || die "could not remove installer checkout"
}

run_install() {
    setup_logging
    preflight
    begin_rollback_state
    install_pacman_packages
    install_aur_packages
    stage "pinned Polychromatic"
    "$ROOT/shared/polychromatic/install.sh"

    if [[ "$MCSR_PLATFORM" == wayland ]]; then
        build_wayland_components
    fi

    deploy_common_configuration
    if [[ "$MCSR_PLATFORM" == wayland ]]; then
        deploy_wayland_configuration
    else
        deploy_x11_configuration
    fi
    enable_system_services
    post_deploy_sanity_check

    create_dovers_artifacts
    finish_rollback_state
    cp -- "$LOG_FILE" "$TARGET_HOME/DoOvers/install-$MCSR_VARIANT.log"
    chmod 600 "$TARGET_HOME/DoOvers/install-$MCSR_VARIANT.log"
    safe_cleanup_checkout

    CURRENT_STAGE="complete"
    printf '\n===== MCSR SETUP COMPLETE =====\n'
    printf 'Installed %s successfully.\n' "$MCSR_VARIANT"
    printf 'Reboot, select the appropriate session, then run %s/verify-install.sh %s.\n' \
        "$TARGET_HOME/DoOvers" "$MCSR_VARIANT"
    printf 'Log: %s\n' "$LOG_FILE"
}
