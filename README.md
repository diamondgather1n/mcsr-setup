# MCSR Setup

This repository is a focused snapshot for Nathan's two MCSR environments.

- `mcsrWL.sh` is for the current Jay/Wayland/Waywall environment.
- `mcsrX11.sh` is for the preserved i3/X11 fallback environment.
- `wayland/` contains files only used by the Wayland setup.
- `x11/` contains files only used by the X11 setup.
- `shared/` contains files intentionally common to both setups.
- `packages/` contains curated package manifests based on the current machine.

The repository is not yet a complete one-command Arch or Minecraft reinstall system. The two shell scripts are deliberate skeletons for that later work.

The live Wayland XKB relationship is currently:

```text
~/.config/xkb/symbols/mcsr
  -> /home/nathan/MCSR/wayland/xkb/symbols/mcsr
```

The X11 configuration is preserved as a fallback/reference and is not enabled by the Wayland setup.
