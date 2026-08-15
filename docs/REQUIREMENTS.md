# Requirements Notes

This is a practical package/application inventory for the tracked configs, not a complete package database or installer.

## Current Wayland Environment

- `jay` / local `jay` wrapper
- `waybar`
- `i3blocks`
- `foot`
- `yazi`
- `fd`
- `ripgrep`
- `micro`
- `imv`
- `mpv`
- `helium-browser`
- `xdg-desktop-portal`, `xdg-desktop-portal-gtk`, `xdg-desktop-portal-kde`, and the Jay portal helper currently used for OBS/Jay capture work

## MCSR / Minecraft

- `waywall`
- Java runtime, including current OpenJDK packages
- MCSR Launcher / Prism-related tools
- Ninjabrain Bot and Paceman Tracker JARs, installed separately
- `curl`, `python3`, and `polychromatic-cli` for Waywall support scripts

## Input

- `keyd`
- Custom XKB files under `MCSR/wayland/xkb`
- X11 tools retained for fallback: `xmodmap`, `xinput`, `wmctrl`, `xdotool`
- `dotool` / related input tools where current Jay scripts use them

## Media / Audio / OBS

- PipeWire, WirePlumber, and Pulse compatibility tools
- `qpwgraph`
- OBS Studio plus browser plugin
- `pactl`, `pw-link`, `pw-dump`, and `wpctl`
- `playerctl`
- `spotify-launcher`

## Legacy X11

- `i3-wm`
- `i3blocks`
- `dmenu`
- `feh`
- `xclip`
- Xorg/XWayland utilities used by the retained fallback scripts

## Optional Tools

- GoCrosshair build dependencies: Go toolchain if rebuilding from source
- `desktop-file-utils` for validating desktop launchers
- `shellcheck` if deeper script linting is wanted later
