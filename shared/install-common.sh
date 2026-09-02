#!/usr/bin/env bash
set -Eeuo pipefail

: "${ROOT:?entry-point script must set ROOT}"
: "${MCSR_VARIANT:?entry-point script must set MCSR_VARIANT}"
: "${MCSR_PLATFORM:?entry-point script must set MCSR_PLATFORM}"
: "${MCSR_TIER:?entry-point script must set MCSR_TIER}"

TARGET_USER="$(id -un)"
TARGET_HOME="${HOME:?HOME is not set}"
CURRENT_STAGE="initialization"

if [[ "$MCSR_PLATFORM" == wayland ]]; then
    OBS_COLLECTION="JAY (wayland)"
    OBS_SCENE_FILE="JAY_wayland"
else
    OBS_COLLECTION="I3 (x11)"
    OBS_SCENE_FILE="I3_x11"
fi

die() {
    printf 'mcsr-setup: %s\n' "$*" >&2
    exit 1
}

on_error() {
    local status=$?
    printf 'mcsr-setup: FAIL during %s (exit %d)\n' "$CURRENT_STAGE" "$status" >&2
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

require_file() {
    [[ -f "$1" ]] || die "missing required source file: $1"
}

require_dir() {
    [[ -d "$1" ]] || die "missing required source directory: $1"
}

require_executable() {
    [[ -x "$1" ]] || die "missing or non-executable source file: $1"
}

deploy_rendered() {
    local src=$1 dest=$2 mode=${3:-644} tmp
    require_file "$src"
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
    mkdir -p "$(dirname "$dest")"
    install -m "$mode" "$src" "$dest"
}

deploy_root_rendered() {
    local src=$1 dest=$2 mode=${3:-644} tmp
    require_file "$src"
    tmp=$(mktemp)
    sed \
        -e "s|@HOME@|$TARGET_HOME|g" \
        -e "s|@USER@|$TARGET_USER|g" \
        -e "s|@OBS_COLLECTION@|$OBS_COLLECTION|g" \
        -e "s|@OBS_SCENE_FILE@|$OBS_SCENE_FILE|g" \
        "$src" >"$tmp"
    sudo install -Dm"$mode" "$tmp" "$dest"
    rm -f -- "$tmp"
}

deploy_tree() {
    local src=$1 dest=$2 entry rel mode target
    require_dir "$src"
    mkdir -p "$dest"

    while IFS= read -r -d '' entry; do
        rel=${entry#"$src/"}
        target="$dest/$rel"
        if [[ -d "$entry" && ! -L "$entry" ]]; then
            mkdir -p "$target"
        elif [[ -L "$entry" ]]; then
            mkdir -p "$(dirname "$target")"
            ln -sfn "$(readlink "$entry")" "$target"
        elif [[ -f "$entry" ]]; then
            mode=644
            [[ -x "$entry" ]] && mode=755
            deploy_rendered "$entry" "$target" "$mode"
        fi
    done < <(find "$src" -mindepth 1 -print0)
}

render_instance_templates() {
    local dest=$1 file mode tmp
    while IFS= read -r -d '' file; do
        grep -IqE '@(HOME|USER)@' "$file" || continue
        mode=$(stat -c '%a' "$file")
        tmp=$(mktemp)
        sed -e "s|@HOME@|$TARGET_HOME|g" -e "s|@USER@|$TARGET_USER|g" "$file" >"$tmp"
        install -m "$mode" "$tmp" "$file"
        rm -f -- "$tmp"
    done < <(find "$dest" -type f -print0)
}

deploy_instance() {
    local src=$1 dest=$2 old_manifest="$dest/.mcsr-setup-manifest" rel
    require_dir "$src"
    mkdir -p "$dest"

    if [[ -f "$old_manifest" ]]; then
        while IFS= read -r rel; do
            [[ -n "$rel" && "$rel" != /* && "$rel" != *'..'* ]] || continue
            [[ -e "$src/$rel" || -L "$src/$rel" ]] || rm -f -- "$dest/$rel"
        done <"$old_manifest"
    fi

    cp -a "$src/." "$dest/"
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
    )
    for source in "${common_sources[@]}"; do
        require_file "$source"
    done
    for source in "${common_executables[@]}"; do
        require_executable "$source"
    done
    require_dir "$ROOT/shared/scripts"
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
            require_file "$ROOT/wayland/waybar/config"
            require_file "$ROOT/wayland/waybar/style.css"
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
        install -Dm755 "$install_root/bin/jay" "$TARGET_HOME/.local/bin/jay.real"

        cc -shared -fPIC -O2 \
            -o "$build_dir/jay-gbm-implicit-modifier.so" \
            "$ROOT/wayland/shims/jay-gbm-implicit-modifier.c" -ldl -lgbm
        install -Dm755 "$build_dir/jay-gbm-implicit-modifier.so" \
            "$TARGET_HOME/.local/lib/jay-gbm-implicit-modifier.so"

        read -r -a gio_flags <<<"$(pkg-config --cflags --libs gio-2.0)"
        cc -shared -fPIC -O2 \
            -o "$build_dir/obs-jay-portal-cursor.so" \
            "$ROOT/wayland/shims/obs-jay-portal-cursor.c" -ldl "${gio_flags[@]}"
        install -Dm755 "$build_dir/obs-jay-portal-cursor.so" \
            "$TARGET_HOME/.local/lib/obs-jay-portal-cursor.so"

        cp -a "$ROOT/wayland/waywall/source" "$build_dir/waywall"
        patch -d "$build_dir/waywall" -p1 <"$ROOT/wayland/waywall/ctrl-scroll-actions.patch"
        make -C "$build_dir/waywall" -j"$(nproc)"
        install -Dm755 "$build_dir/waywall/build/waywall/waywall" \
            "$TARGET_HOME/.local/bin/waywall-ctrl-scroll"
    )

    deploy_copy "$ROOT/wayland/shims/jay-gbm-implicit-modifier.c" \
        "$TARGET_HOME/.local/src/jay-gbm-implicit-modifier.c"
    deploy_copy "$ROOT/wayland/shims/obs-jay-portal-cursor.c" \
        "$TARGET_HOME/.local/src/obs-jay-portal-cursor.c"
    deploy_rendered "$ROOT/wayland/helpers/jay" "$TARGET_HOME/.local/bin/jay" 755
    [[ "$("$TARGET_HOME/.local/bin/jay" version)" == "1.14.0" ]] || die "built Jay did not report version 1.14.0"
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
        rm -f -- "$TARGET_HOME/.local/share/applications/foot.desktop"
    fi
    deploy_tree "$ROOT/shared/zellij" "$TARGET_HOME/.config/zellij"
    deploy_rendered "$ROOT/shared/foot/foot.ini" "$TARGET_HOME/.config/foot/foot.ini"
    deploy_rendered "$ROOT/shared/applications/mimeapps.list" "$TARGET_HOME/.config/mimeapps.list"

    deploy_root_rendered "$ROOT/shared/keyd/normal.conf" /etc/keyd/normal.conf

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

    mkdir -p "$TARGET_HOME/MCSR/CrossDisplayManager/obs images"
    cp -a "$ROOT/shared/obs/assets/." "$TARGET_HOME/MCSR/CrossDisplayManager/obs images/"
    deploy_rendered "$ROOT/shared/obs/global.ini" "$TARGET_HOME/.config/obs-studio/global.ini"
    deploy_rendered "$ROOT/shared/obs/user.ini" "$TARGET_HOME/.config/obs-studio/user.ini"
    for file in basic.ini recordEncoder.json streamEncoder.json; do
        deploy_rendered "$ROOT/shared/obs/profiles/$file" \
            "$TARGET_HOME/.config/obs-studio/basic/profiles/optimized/$file"
    done

    if command -v update-desktop-database >/dev/null; then
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
    mkdir -p "$TARGET_HOME/.config/xkb/symbols"
    ln -sfn "$TARGET_HOME/MCSR/wayland/xkb/symbols/mcsr" "$TARGET_HOME/.config/xkb/symbols/mcsr"

    for file in foot-tabbed jay-desktop-launcher; do
        deploy_rendered "$ROOT/wayland/helpers/$file" "$TARGET_HOME/.local/bin/$file" 755
    done
    if [[ "$MCSR_TIER" == L ]]; then
        for file in "$ROOT/wayland/helpers/"*; do
            [[ -f "$file" ]] && deploy_rendered "$file" "$TARGET_HOME/.local/bin/$(basename "$file")" 755
        done
        deploy_rendered "$ROOT/wayland/waybar/config" "$TARGET_HOME/.config/waybar/config"
        deploy_rendered "$ROOT/wayland/waybar/style.css" "$TARGET_HOME/.config/waybar/style.css"
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

    systemctl --user daemon-reload
    systemctl --user enable xdg-desktop-portal-jay.service obs-input-overlay.service
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
    sudo usermod -aG input "$TARGET_USER"
    if getent group plugdev >/dev/null; then
        sudo usermod -aG plugdev "$TARGET_USER"
    fi
    systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
    sudo systemctl enable NetworkManager.service keyd.service lightdm.service
}

run_install() {
    preflight
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

    CURRENT_STAGE="complete"
    printf '\nInstalled %s successfully. Reboot, select the appropriate session, then run ./verify-install.sh %s.\n' \
        "$MCSR_VARIANT" "$MCSR_VARIANT"
}
