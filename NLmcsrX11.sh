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
mapfile -t x11 < <(read_list "$ROOT/packages/pacman-x11.txt")
sudo pacman -Syu --needed "${common[@]}" "${x11[@]}"
if ! command -v yay >/dev/null 2>&1; then
    yay_tmp="$(mktemp -d)"
    trap 'rm -rf "$yay_tmp"' EXIT
    git clone --depth=1 https://aur.archlinux.org/yay.git "$yay_tmp/yay"
    (cd "$yay_tmp/yay" && makepkg -si --needed)
fi
mapfile -t aur_common < <(read_list "$ROOT/packages/yay-common.txt")
mapfile -t aur_x11 < <(read_list "$ROOT/packages/yay-x11.txt")
yay -S --needed "${aur_common[@]}" "${aur_x11[@]}"
"$ROOT/shared/polychromatic/install.sh"

install -Dm644 "$ROOT/x11/i3/NL-config" "$HOME/.config/i3/config"
install -Dm644 "$ROOT/shared/zellij/config-x11.kdl" "$HOME/.config/zellij/config-x11.kdl"
install -Dm644 "$ROOT/shared/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
for f in "$ROOT/x11/xmodmap/"*; do [[ -f "$f" ]] && install -Dm644 "$f" "$HOME/MCSR/x11/xmodmap/$(basename "$f")"; done
for f in "$ROOT/x11/macros/"* "$ROOT/x11/shell-scripts/"*; do [[ -f "$f" ]] && install -Dm755 "$f" "$HOME/MCSR/x11/$(basename "$(dirname "$f")")/$(basename "$f")"; done
for f in "$ROOT/shared/scripts/"*; do [[ -f "$f" ]] && install -Dm755 "$f" "$HOME/.local/bin/$(basename "$f")"; done
sudo install -Dm644 "$ROOT/shared/keyd/normal.conf" /etc/keyd/normal.conf
sudo systemctl enable --now keyd.service
install -Dm644 "$ROOT/shared/mcsr/launcher/Ninjabrain-Bot-1.5.2.jar" "$HOME/.config/waywall/resources/Ninjabrain-Bot-1.5.2.jar"
install -Dm644 "$ROOT/shared/mcsr/launcher/paceman-tracker-0.7.2.jar" "$HOME/.config/waywall/resources/paceman-tracker-0.7.2.jar"
install -Dm644 "$ROOT/shared/mcsr/launcher/fix-ninbot-hotkeys.py" "$HOME/.config/waywall/resources/fix-ninbot-hotkeys.py"
mkdir -p "$HOME/MCSR/CrossDisplayManager/MCSRlauncher" "$HOME/MCSR/CrossDisplayManager/jarfiles"
install -Dm644 "$ROOT/shared/mcsr/launcher/MCSRLauncher.jar" "$HOME/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar"
install -Dm644 "$ROOT/shared/mcsr/launcher/options.json" "$HOME/MCSR/CrossDisplayManager/MCSRlauncher/launcher/options.json"
cp -a "$ROOT/shared/mcsr/launcher/Ninjabrain-Bot-1.5.2.jar" "$HOME/MCSR/CrossDisplayManager/jarfiles/"
cp -a "$ROOT/shared/mcsr/launcher/paceman-tracker-0.7.2.jar" "$HOME/MCSR/CrossDisplayManager/jarfiles/"
for instance in ranked seedqueue "x11 ranked" "1.21.1 ssg"; do
    src="$ROOT/shared/minecraft/instances/$instance"
    [[ -d "$src" ]] || continue
    mkdir -p "$HOME/.local/share/PrismLauncher/instances"
    cp -a "$src" "$HOME/.local/share/PrismLauncher/instances/"
done
mkdir -p "$HOME/MCSR/CrossDisplayManager/obs images"
cp -a "$ROOT/shared/obs/assets/." "$HOME/MCSR/CrossDisplayManager/obs images/"
install -Dm644 "$ROOT/shared/obs/scenes/I3_x11.json" "$HOME/.config/obs-studio/basic/scenes/I3_x11.json"
install -Dm644 "$ROOT/shared/obs/profiles/basic.ini" "$HOME/.config/obs-studio/basic/profiles/optimized/basic.ini"
install -Dm644 "$ROOT/shared/obs/profiles/recordEncoder.json" "$HOME/.config/obs-studio/basic/profiles/optimized/recordEncoder.json"
install -Dm644 "$ROOT/shared/obs/profiles/streamEncoder.json" "$HOME/.config/obs-studio/basic/profiles/optimized/streamEncoder.json"
sudo systemctl enable lightdm.service
echo "Installed NL X11 diagnostic setup; i3blocks, wallpaper, dex, app startup, placement helpers and OBS itself were not started."
