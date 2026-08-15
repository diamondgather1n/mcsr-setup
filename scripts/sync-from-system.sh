#!/usr/bin/env bash
set -Eeuo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
home_dir="/home/nathan"

warn() {
  printf 'warning: %s\n' "$*" >&2
}

copy_file() {
  local src="$1"
  local dst="$2"
  local required="${3:-required}"

  if [[ ! -e "$src" ]]; then
    if [[ "$required" == "required" ]]; then
      warn "missing required file: $src"
    fi
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  cp -a "$src" "$dst"
}

copy_dir_contents() {
  local src="$1"
  local dst="$2"
  shift 2

  if [[ ! -d "$src" ]]; then
    warn "missing directory: $src"
    return 0
  fi

  mkdir -p "$dst"
  find "$src" -mindepth 1 -maxdepth 1 "$@" -exec cp -a -t "$dst" {} +
}

copy_named_bin() {
  local name="$1"
  copy_file "$home_dir/.local/bin/$name" "$repo_root/home/.local/bin/$name" optional
}

copy_named_desktop() {
  local name="$1"
  copy_file "$home_dir/.local/share/applications/$name" "$repo_root/home/.local/share/applications/$name" optional
}

mkdir -p \
  "$repo_root/home/.config" \
  "$repo_root/home/.local/bin" \
  "$repo_root/home/.local/share/applications" \
  "$repo_root/system/etc/keyd" \
  "$repo_root/MCSR" \
  "$repo_root/applications/gocrosshair"

copy_file "$home_dir/.config/jay/config.toml" "$repo_root/home/.config/jay/config.toml"
copy_dir_contents "$home_dir/.config/waywall" "$repo_root/home/.config/waywall" \
  ! -name '*.bak' \
  ! -name '*codex*' \
  ! -name 'resources' \
  ! -name '*.jar' \
  ! -name '__pycache__'
copy_dir_contents "$home_dir/.config/waywall/resources" "$repo_root/home/.config/waywall/resources" \
  ! -name '*.jar' \
  ! -name '*.pyc' \
  ! -name '__pycache__'
copy_dir_contents "$home_dir/.config/waybar" "$repo_root/home/.config/waybar" \
  ! -name '*.bak' \
  ! -name '*codex*'
copy_dir_contents "$home_dir/.config/i3" "$repo_root/home/.config/i3" \
  ! -name '*.bak' \
  ! -name '*codex*'
copy_dir_contents "$home_dir/.config/i3blocks" "$repo_root/home/.config/i3blocks" \
  ! -name '*.bak' \
  ! -name '*codex*'
copy_dir_contents "$home_dir/.config/yazi" "$repo_root/home/.config/yazi" \
  ! -name '*.bak' \
  ! -name '*codex*'
copy_dir_contents "$home_dir/.config/xkb" "$repo_root/home/.config/xkb" \
  ! -name '*.bak' \
  ! -name '*codex*'
copy_file "$home_dir/.config/mimeapps.list" "$repo_root/home/.config/mimeapps.list"
copy_dir_contents "$home_dir/.config/gocrosshair" "$repo_root/home/.config/gocrosshair" \
  ! -name '*.bak' \
  ! -name '*codex*'

copy_dir_contents "$home_dir/.config/systemd/user" "$repo_root/home/.config/systemd/user" \
  -name '*.service'

copy_named_desktop yazi-foot.desktop
copy_named_desktop micro-foot.desktop
copy_named_desktop imv.desktop
copy_named_desktop com.obsproject.Studio.desktop
copy_named_desktop en-croissant-file.desktop
copy_named_desktop input-remapper-gtk.desktop

for name in \
  mcsrlauncher mcsr-update-launcher \
  mcsr-macro-thin mcsr-macro-wide mcsr-macro-zoom mcsr-macro-dpilesszoom \
  mcsr-macro-restart-ninjabrain \
  mcsr-speedrun-toggle mcsr-speedrun-on mcsr-speedrun-off mcsr-speedrun-set mcsr-speedrun-only \
  mcsr-place-windows mcsr-write-bar-colors mcsr-dpi \
  jay jay-startup-windows jay-lag-monitor jay-input-sanitizer \
  i3blocks-speedrun bar-cpu bar-gpu bar-net bar-volume \
  spotify ninjabrain restart-ninjabrain \
  obs obs-audio-autolink obs-capture-visibility obs-input-overlay obs-numpad-hotkeys \
  audio-output-switch audio-earbuds audio-monitor HeadPhones EarBuds MonitorAudio \
  obs-mic-switch headphones-mic-setup \
  laptop-mic-cable-start laptop-mic-cable-stop laptop-mic-laptop-send \
  laptop-mic-pc-receive laptop-mic-pc-use-analog laptop-mic-ssh-play \
  chromebook-mic-web-direct chromebook-mic-web-receiver \
  chromebook-remote-web-direct chromebook-remote-web-receiver \
  input-recorder
do
  copy_named_bin "$name"
done

copy_dir_contents "$home_dir/MCSR/x11" "$repo_root/MCSR/x11" \
  ! -name '.directory'
copy_dir_contents "$home_dir/MCSR/wayland" "$repo_root/MCSR/wayland" \
  ! -name '.directory'

copy_file "$home_dir/MCSR/CrossDisplayManager/obs images/background.jpg" "$repo_root/MCSR/assets/background.jpg" optional
copy_file "$home_dir/MCSR/CrossDisplayManager/obs images/DSCN0453.png" "$repo_root/MCSR/assets/DSCN0453.png" optional

copy_dir_contents /etc/keyd "$repo_root/system/etc/keyd" \
  -name '*.conf'

copy_file "$home_dir/.config/gocrosshair/config.toml" "$repo_root/applications/gocrosshair/config.toml" optional
for name in README.md LICENSE PKGBUILD go.mod go.sum main.go gocrosshair.desktop gocrosshair.png icon.png .gitignore; do
  copy_file "$home_dir/gocrosshair/$name" "$repo_root/applications/gocrosshair/$name" optional
done
copy_dir_contents "$home_dir/gocrosshair/config" "$repo_root/applications/gocrosshair/config" \
  -type f
copy_dir_contents "$home_dir/gocrosshair/overlay" "$repo_root/applications/gocrosshair/overlay" \
  -type f
copy_dir_contents "$home_dir/gocrosshair/wizard" "$repo_root/applications/gocrosshair/wizard" \
  -type f

find "$repo_root" \
  \( -name '*.bak' -o -name '*.backup' -o -name '*.old' -o -name '*.tmp' -o -name '*.swp' -o -name '*.swo' -o -name '*~' -o -name '*.log' -o -name '*.pyc' -o -name '*.jar' -o -name '.directory' \) \
  -type f -delete
find "$repo_root" \
  \( -name '__pycache__' -o -name '.cache' \) \
  -type d -prune -exec rm -rf {} +
rm -f "$repo_root/home/.local/bin/jay.real" "$repo_root"/home/.local/bin/jay-*-backup-*
rm -f "$repo_root/applications/gocrosshair/gocrosshair"

echo "Synced known configuration files into $repo_root"
