# Runtime Deployment Matrix

The installer runs as the target normal user. User files are installed into that user's home; only keyd, LightDM session metadata, and Jay portal metadata use the system root.

| Repository source | NL Wayland destination | NL X11 destination | Notes |
| --- | --- | --- | --- |
| `wayland/jay/NL-config.toml` | `~/.config/jay/config.toml` | Not installed | Render `@HOME@`; desktop XKB stays `gb,no`; Waybar starts from its marked entry. |
| `wayland/waywall/NL-init.lua` | `~/.config/waywall/init.lua` | Not installed | Rendered config; Waywall applies the `mcsr` layout. |
| `wayland/waywall/resources/` | `~/.config/waywall/resources/` | Not installed | Complete configured overlays, helper, and Ninjabrain/Paceman JARs. |
| `wayland/xkb/symbols/mcsr` | `~/MCSR/wayland/xkb/symbols/mcsr` and `~/.config/xkb/symbols/mcsr` symlink | Not installed | Symlink points at the copied source. |
| `shared/foot/foot.ini` | `~/.config/foot/foot.ini` | Same | Live Foot config. |
| `shared/zellij/` | `~/.config/zellij/` | Same, including X11 config | Render `@HOME@` in KDL. |
| `shared/yazi/` | `~/.config/yazi/` | Same | Current live config and required plugin sources. |
| Yazi helpers in `shared/scripts/` | `~/.local/bin/` | Same | Installed executable with mode 0755. |
| `shared/keyd/normal.conf` | `/etc/keyd/normal.conf` | Same | Installed by sudo; keyd is enabled and started, then checked active. |
| `shared/applications/desktop/` | `~/.local/share/applications/` | Same, except Wayland-only Foot launcher | Rendered where templates require it. |
| `shared/applications/mimeapps.list` | `~/.config/mimeapps.list` | Same | Rendered. |
| `shared/mcsr/launcher/` | MCSR launcher JARs/options under `~/MCSR/CrossDisplayManager/` and `~/launcher/` | Same | Authentication data is not included. |
| `shared/minecraft/instances/waywall` | `~/launcher/instances/waywall/` | Not installed | Source instance is Ranked2; keeps its explicit Java 21 path and target user's Waywall wrapper. |
| `shared/minecraft/instances/MCSRRanked` | Not installed | `~/launcher/instances/MCSRRanked/` | Source instance is Ranked; explicitly pinned to Java 21 so Java 26 cannot change MCSR runtime behavior. |
| `shared/obs/` | `~/.config/obs-studio/`, `~/MCSR/CrossDisplayManager/obs images/`, overlay under `~/.local/share/obs-input-overlay/` | Scene/profile/assets under corresponding native OBS paths | OBS is configured but not started by install. |
| `wayland/waybar/{config,style.css}` | NL only: `~/.config/waybar/` | Not installed | NL Jay starts it through the uniquely marked `MCSR_SETUP_WAYBAR_START` entry. The package is in the shared Wayland manifest but L does not start it. |
| `wayland/jay/source/etc/jay.desktop` | `/usr/share/wayland-sessions/jay.desktop` | Not installed | `Exec` is rendered to the target user's absolute `~/.local/bin/jay run`. |
| Jay portal metadata/service | `/usr/share/xdg-desktop-portal/` and `~/.config/systemd/user/` | Not installed | Portal service is enabled for Wayland. |
| `x11/i3/`, Xmodmap, macros, scripts | Not installed | `~/.config/i3/` and `~/MCSR/x11/` | X11-only fallback. |

Install rollback metadata is stored privately under `~/DoOvers/state/`. `~/DoOvers/reset.sh` restores only unchanged installer-written paths and attempts non-recursive removal of packages added by that run. Pacman upgrades themselves are not downgraded. The NL Wayland `undo-waybar.sh` removes only its marked Jay startup entry, unchanged deployed bar files, and Waybar only when the package was newly installed.
