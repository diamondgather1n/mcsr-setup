# Non-pacman installation sources

This file records provenance for components that are not installed directly
from the official Arch repositories. Paths under `/home/nathan` describe the
audited reference machine only; installed runtime files use rendered target
paths.

## Jay

- Reference commands: `/home/nathan/.local/bin/jay` and `jay.real`.
- Version: `1.14.0`; upstream release commit `1430d6b`.
- The exact Cargo source and lock file are vendored under
  `wayland/jay/source/`.
- Both Wayland installers run `cargo install --path ... --locked` into a
  temporary root, then install the binary as `~/.local/bin/jay.real`.
- The portable wrapper is rendered to `~/.local/bin/jay` so the LightDM
  session has an absolute executable and does not depend on shell `PATH`.
- Source for the audited GBM compatibility preload is preserved at
  `wayland/shims/jay-gbm-implicit-modifier.c` and compiled during setup.
- Jay's portal metadata and the user service are installed explicitly. The
  repository selects the official GTK portal for file selection.

## Waywall

- Reference package: `waywall-working-git`
  `0.2026.02.06.r5.g5cd802b-1`.
- Upstream: `https://github.com/tesselslate/waywall`.
- Exact source commit: `5cd802b3a4b3e3a87186263f876aa6e060a7ba23`,
  vendored under `wayland/waywall/source/`.
- The audited input-action patch is
  `wayland/waywall/ctrl-scroll-actions.patch` with SHA-256
  `0e3e51805a1c4c1554ad4c792a9805ed0702af75bc2647e977c2b4c5d18de903`.
- Both Wayland installers build that source and patch deterministically and
  install `~/.local/bin/waywall-ctrl-scroll`. They do not substitute a newer
  moving AUR checkout.

## Helium

- The working reference installation was inspected with `command -v`,
  `pacman -Qo`, foreign-package queries, and its desktop entry.
- Actual package: AUR `helium-browser-bin`.
- Reference version: `0.10.8.1-1`.
- Executable: `/usr/bin/helium-browser`.
- Desktop entry: `/usr/share/applications/helium.desktop`.
- `yay-common.txt` reproduces this method. Firefox or Chromium is not used as
  a replacement.

## Polychromatic and OpenRazer

- Reference Polychromatic source commit:
  `87cff1dd78555a5514a29f1221c5d03d31bb68e8`.
- The source and pinned package recipe are under `shared/polychromatic/` and
  are built locally with `makepkg`.
- OpenRazer is installed from Arch dependencies. Membership in `plugdev` is
  added when that group exists, and the DPI command is guarded by live Razer
  mouse detection.

## GoCrosshair

- X11 fallback source commit: `77358e957702b9db11114b5fcebbb1c59f2e565d`.
- X11 installers use the AUR `gocrosshair` package and its packaged command.

## MCSR and Minecraft

- MCSRLauncher was audited from
  `/home/nathan/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar`.
- Active launcher runtime data is under `/home/nathan/launcher/`; installation
  therefore places options and instances under the target user's `~/launcher`.
- Ninjabrain Bot `1.5.2` and Paceman Tracker `0.7.2` are retained in both the
  Waywall resource tree and `~/MCSR/CrossDisplayManager/jarfiles`.
- `/home/nathan/launcher/instances/Ranked` maps to repository/install instance
  `MCSRRanked` for X11.
- `/home/nathan/launcher/instances/Ranked2` maps to repository/install instance
  `waywall` for Wayland.
- Named practice maps, configs, mods, options, hotbar data, natives, and Fabric
  data are retained. Logs, crash dumps, screenshots, session locks, Hermes
  process snapshots, user cache, replay caches, and generated reset/ranked
  worlds are excluded.

## OBS

- The native configuration source is `/home/nathan/.config/obs-studio/`; no
  Flatpak path is used.
- Scene collections preserve browser sources, image assets, PipeWire sources,
  layering, and the current Mic/Aux RNNoise, compressor, expander, and limiter
  filter chain.
- `obs-studio-plugin-browser` is installed from Arch.
- Source for the Jay portal cursor compatibility preload is preserved at
  `wayland/shims/obs-jay-portal-cursor.c` and compiled during Wayland setup.
- Portable scene copies omit portal restore tokens, Twitch credentials, stream
  keys, and private SoundAlerts identifiers. Those are manual post-install
  steps.

## Authentication boundary

Never add any `accounts.json`, OBS `service.json`, GitHub token, authenticator
secret, Microsoft/Minecraft token, Twitch token, or stream key. The repository
`.gitignore` rejects the launcher and OBS credential filenames, and validation
also scans tracked files before push.

The optional live updater for MCSRLauncher is not included: it is not required
to launch the pinned JAR and relied on JDK tooling not guaranteed by the JRE
baseline.
