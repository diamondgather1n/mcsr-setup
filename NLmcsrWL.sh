#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
[[ "${USER:-}" == "nathan" ]] || { echo "Run this as user nathan, not root." >&2; exit 1; }
(( EUID != 0 )) || { echo "Do not run this script as root; it uses sudo for system files." >&2; exit 1; }
command -v pacman >/dev/null || { echo "pacman is required." >&2; exit 1; }
command -v sudo >/dev/null || { echo "sudo is required." >&2; exit 1; }
sudo -v

read_list() { grep -Ev '^[[:space:]]*(#|$)' "$1"; }
mapfile -t common < <(read_list "$ROOT/packages/pacman-common.txt")
mapfile -t wayland < <(read_list "$ROOT/packages/pacman-wayland.txt")
sudo pacman -Syu --needed "${common[@]}" "${wayland[@]}"
if ! command -v yay >/dev/null 2>&1; then
    yay_tmp="$(mktemp -d)"
    trap 'rm -rf "$yay_tmp"' EXIT
    git clone --depth=1 https://aur.archlinux.org/yay.git "$yay_tmp/yay"
    (cd "$yay_tmp/yay" && makepkg -si --needed)
fi
mapfile -t aur_common < <(read_list "$ROOT/packages/yay-common.txt")
mapfile -t aur_wayland < <(read_list "$ROOT/packages/yay-wayland.txt")
yay -S --needed "${aur_common[@]}" "${aur_wayland[@]}"

command -v cargo >/dev/null || { echo "cargo is required after installing rust." >&2; exit 1; }
cargo install --path "$ROOT/wayland/jay/source" --locked --root "$HOME/.local"
test "$("$HOME/.local/bin/jay" version)" = "1.14.0"
sudo install -Dm644 "$ROOT/wayland/jay/source/etc/jay.desktop" /usr/share/wayland-sessions/jay.desktop
"$ROOT/shared/polychromatic/install.sh"

install -Dm644 "$ROOT/wayland/jay/NL-config.toml" "$HOME/.config/jay/config.toml"
install -Dm644 "$ROOT/wayland/waywall/NL-init.lua" "$HOME/.config/waywall/init.lua"
mkdir -p "$HOME/.config/waywall/resources"
cp -a "$ROOT/wayland/waywall/resources/." "$HOME/.config/waywall/resources/"
install -Dm644 "$ROOT/wayland/xkb/symbols/mcsr" "$HOME/MCSR/wayland/xkb/symbols/mcsr"
mkdir -p "$HOME/.config/xkb/symbols"
ln -sfn "$HOME/MCSR/wayland/xkb/symbols/mcsr" "$HOME/.config/xkb/symbols/mcsr"
for f in "$ROOT/wayland/helpers/foot-tabbed" "$ROOT/wayland/helpers/jay-desktop-launcher"; do
    install -Dm755 "$f" "$HOME/.local/bin/$(basename "$f")"
done
for f in "$ROOT/shared/scripts/"*; do
    [[ -f "$f" ]] && install -Dm755 "$f" "$HOME/.local/bin/$(basename "$f")"
done
install -Dm644 "$ROOT/shared/foot/foot.ini" "$HOME/.config/foot/foot.ini"
install -Dm644 "$ROOT/shared/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
sudo install -Dm644 "$ROOT/shared/keyd/normal.conf" /etc/keyd/normal.conf
sudo systemctl enable --now keyd.service
mkdir -p "$HOME/MCSR/CrossDisplayManager/jarfiles" "$HOME/MCSR/CrossDisplayManager/MCSRlauncher"
install -Dm644 "$ROOT/shared/mcsr/launcher/MCSRLauncher.jar" "$HOME/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar"
install -Dm644 "$ROOT/shared/mcsr/launcher/options.json" "$HOME/MCSR/CrossDisplayManager/MCSRlauncher/launcher/options.json"
install -Dm644 "$ROOT/shared/mcsr/launcher/Ninjabrain-Bot-1.5.2.jar" "$HOME/.config/waywall/resources/Ninjabrain-Bot-1.5.2.jar"
install -Dm644 "$ROOT/shared/mcsr/launcher/paceman-tracker-0.7.2.jar" "$HOME/.config/waywall/resources/paceman-tracker-0.7.2.jar"
for instance in ranked seedqueue "x11 ranked" "1.21.1 ssg"; do
    src="$ROOT/shared/minecraft/instances/$instance"
    [[ -d "$src" ]] || continue
    mkdir -p "$HOME/.local/share/PrismLauncher/instances"
    cp -a "$src" "$HOME/.local/share/PrismLauncher/instances/"
done
mkdir -p "$HOME/MCSR/CrossDisplayManager/obs images"
cp -a "$ROOT/shared/obs/assets/." "$HOME/MCSR/CrossDisplayManager/obs images/"
install -Dm644 "$ROOT/shared/obs/scenes/JAY_wayland.json" "$HOME/.config/obs-studio/basic/scenes/JAY_wayland.json"
install -Dm644 "$ROOT/shared/obs/profiles/basic.ini" "$HOME/.config/obs-studio/basic/profiles/optimized/basic.ini"
install -Dm644 "$ROOT/shared/obs/profiles/recordEncoder.json" "$HOME/.config/obs-studio/basic/profiles/optimized/recordEncoder.json"
install -Dm644 "$ROOT/shared/obs/profiles/streamEncoder.json" "$HOME/.config/obs-studio/basic/profiles/optimized/streamEncoder.json"
mkdir -p "$HOME/.local/share/obs-input-overlay"
install -Dm644 "$ROOT/shared/obs/input-overlay/index.html" "$HOME/.local/share/obs-input-overlay/index.html"
install -Dm644 "$ROOT/shared/obs/input-overlay/overlay.css" "$HOME/.local/share/obs-input-overlay/overlay.css"
install -Dm644 "$ROOT/shared/obs/input-overlay/overlay.js" "$HOME/.local/share/obs-input-overlay/overlay.js"
sudo systemctl enable lightdm.service
echo "Installed NL Wayland diagnostic setup; Waybar, portals, startup automation, OBS overlay service and OBS itself were not started."
