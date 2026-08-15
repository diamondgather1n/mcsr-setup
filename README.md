# Nathan MCSR Config

This repository stores Nathan's Arch Linux desktop and MCSR configuration.

The current environment is Jay on Wayland with Waywall for MCSR. The old i3/X11 setup is intentionally preserved as a fallback and reference, not rewritten or modernised.

This is a configuration and script snapshot. It is not yet a complete reinstall/bootstrap system. The longer-term goal is to make the setup reproducible from a clean Arch installation.

## Layout

- `home/.config/` - user configuration for Jay, Waywall, Waybar, i3, i3blocks, Yazi, XKB, GoCrosshair, and MIME defaults.
- `home/.local/bin/` - selected user scripts used by the desktop/MCSR/audio/OBS workflow.
- `home/.local/share/applications/` - selected user desktop launchers and MIME helpers.
- `system/etc/keyd/` - keyd configuration copied from `/etc/keyd`.
- `MCSR/x11/` - legacy/fallback X11 macro, layout, and shell-script setup.
- `MCSR/wayland/` - current Wayland-specific custom XKB source.
- `applications/gocrosshair/` - GoCrosshair source/support files plus the live user config.
- `scripts/` - repository maintenance scripts.
- `docs/` - file map, requirements notes, and manual restore notes.

Hardware IDs, monitor names, paths, audio node names, and input device names are Nathan-specific and may need adjustment on another machine.
