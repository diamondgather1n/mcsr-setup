# File Map

This map records live source paths and their repository destinations.

| Status | Live Path | Repository Path |
|---|---|---|
| CURRENT | `~/.config/jay/config.toml` | `home/.config/jay/config.toml` |
| CURRENT | `~/.config/waywall/` | `home/.config/waywall/` |
| ASSET | `~/.config/waywall/resources/*.png` and support scripts | `home/.config/waywall/resources/` |
| OMITTED BINARY | `~/.config/waywall/resources/*.jar` | Not tracked; install separately |
| CURRENT | `~/.config/waybar/` | `home/.config/waybar/` |
| CURRENT | `~/.config/zellij/` | `home/.config/zellij/` |
| CURRENT | `~/.config/i3blocks/config` | `home/.config/i3blocks/config` |
| CURRENT | `~/.config/yazi/` | `home/.config/yazi/` |
| CURRENT | `~/.config/micro/settings.json` and `bindings.json` | `home/.config/micro/` |
| CURRENT | `~/.config/environment.d/10-editor.conf` | `home/.config/environment.d/10-editor.conf` |
| CURRENT | `~/.config/xdg-desktop-portal/portals.conf` | `home/.config/xdg-desktop-portal/portals.conf` |
| CURRENT | `~/.config/mimeapps.list` | `home/.config/mimeapps.list` |
| CURRENT | `~/.config/systemd/user/*.service` | `home/.config/systemd/user/` |
| CURRENT | `~/.local/share/applications/yazi-foot.desktop` | `home/.local/share/applications/yazi-foot.desktop` |
| CURRENT | `~/.local/share/applications/micro-foot.desktop` | `home/.local/share/applications/micro-foot.desktop` |
| CURRENT | `~/.local/share/applications/imv.desktop` | `home/.local/share/applications/imv.desktop` |
| CURRENT | `~/.local/share/applications/foot.desktop` | `home/.local/share/applications/foot.desktop` |
| CURRENT | `~/.local/share/applications/com.obsproject.Studio.desktop` | `home/.local/share/applications/com.obsproject.Studio.desktop` |
| SCRIPT | selected `~/.local/bin/` scripts | `home/.local/bin/` |
| LEGACY/FALLBACK | `~/.config/i3/` | `home/.config/i3/` |
| LEGACY/FALLBACK | `~/MCSR/x11/` | `MCSR/x11/` |
| CURRENT | `~/MCSR/wayland/xkb/symbols/mcsr` | `MCSR/wayland/xkb/symbols/mcsr` |
| CURRENT SYMLINK | `~/.config/xkb/symbols/mcsr -> ~/MCSR/wayland/xkb/symbols/mcsr` | `home/.config/xkb/symbols/mcsr` symlink copy plus source under `MCSR/wayland/xkb/symbols/mcsr` |
| CURRENT | `~/.config/xkb/symbols/inet` | `home/.config/xkb/symbols/inet` |
| SYSTEM | `/etc/keyd/normal.conf` | `system/etc/keyd/normal.conf` |
| SYSTEM | `/etc/keyd/speedrun.conf` | `system/etc/keyd/speedrun.conf` |
| ASSET | `~/MCSR/CrossDisplayManager/obs images/background.jpg` | `MCSR/assets/background.jpg` |
| ASSET | `~/MCSR/CrossDisplayManager/obs images/DSCN0453.png` | `MCSR/assets/DSCN0453.png` |
| CURRENT | `~/.config/gocrosshair/config.toml` | `home/.config/gocrosshair/config.toml` and `applications/gocrosshair/config.toml` |
| SCRIPT | `~/gocrosshair/` source/support files | `applications/gocrosshair/` |
| OMITTED BINARY | `~/gocrosshair/gocrosshair` | Not tracked; rebuild/install separately |

Backup files, Codex-generated `.bak` files, logs, caches, temporary migration scripts, generated tokens/certificates, JARs, and compiled binaries are deliberately excluded.
