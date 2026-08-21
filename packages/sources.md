# Non-pacman installation sources

This file records live provenance and the non-pacman build steps used by the
four setup scripts.

## Jay

- Command: `/home/nathan/.local/bin/jay`
- Real binary: `/home/nathan/.local/bin/jay.real`
- Reported version: `1.14.0` (`jay version`)
- Upstream repository: `https://github.com/mahkoh/jay`
- Upstream release 1.14.0 commit: `1430d6b`
- The exact `jay-compositor-1.14.0` Cargo source and `Cargo.lock` are vendored
  under `wayland/jay/source/`. Both Wayland installers run
  `cargo install --path ... --locked --root "$HOME/.local"` and verify that
  the resulting binary reports `1.14.0`.
- The source build was verified offline on the reference machine. It is the
  reproducible Jay plan; `jay-git` is intentionally not used because it would
  move the setup to an unpinned development revision.
- Jay's pinned installation guide was checked for direct native requirements.
  `rust` is the build requirement; `libinput`, `systemd-libs`, `pango`,
  `fontconfig`, `mesa`, and `vulkan-icd-loader` are explicitly listed in the
  Wayland manifest for its configured Vulkan runtime and native input/display
  interfaces.
- `jay.real` SHA-256: `3e1a4b5cfdad4aa8185fc4b1127900f79acb1c52bc17fe6767c1aea65e533fb9`
- Wrapper SHA-256: `1ed09b87bba1c9e8be5037569008db5bde05cecd915c31f837b7691eaca56ab0`
- The wrapper preloads the local GBM shim
  `/home/nathan/.local/lib/jay-gbm-implicit-modifier.so`; the compiled shim is
  intentionally not copied into Git. Its SHA-256 is
  `23b3723a63aa72f096403c07c90dc9df5221b410af43a2bbc55f681c1cc2ff60`.
- The current local GBM preload shim has no preserved source, so it is not
  installed by the reproducible setup. The clean upstream 1.14.0 build is
  used instead of carrying an opaque compiled shim.

## Waywall

- Installed command: `/usr/bin/waywall`
- Package: `waywall-working-git`
- Installed version: `0.2026.02.06.r5.g5cd802b-1`
- Upstream: `https://github.com/tesselslate/waywall`
- The project documents `waywall-working-git` as its Arch AUR package.

## Polychromatic

- Live command: `/usr/bin/polychromatic-cli`; no pacman owner.
- Local build tree: `/home/nathan/polychromatic-git`
- AUR build tree commit: `6f5ca555bf98171e83510bb6047f2ec085acfc55`
- AUR remote: `https://aur.archlinux.org/polychromatic-git.git`
- Source remote: `https://github.com/polychromatic/polychromatic.git`
- Source commit: `87cff1dd78555a5514a29f1221c5d03d31bb68e8`
- The repository copy includes the source and PKGBUILD metadata, but not the
  local package archive, `pkg/`, nested `.git`, or generated build outputs.
- `shared/polychromatic/PKGBUILD.pinned` and `install.sh` build the vendored
  source at commit `87cff1dd78555a5514a29f1221c5d03d31bb68e8` without cloning a
  newer revision. The resulting package provides `/usr/bin/polychromatic-cli`.

## GoCrosshair

- Current X11 scripts used `/home/nathan/gocrosshair/gocrosshair`; the repo
  version uses the packaged command `gocrosshair`.
- Current checkout: `/home/nathan/gocrosshair`
- Remote: `https://github.com/MatheusLasserre/gocrosshair.git`
- Current checkout commit: `77358e957702b9db11114b5fcebbb1c59f2e565d`
- The upstream project documents an AUR package named `gocrosshair`, so that
  package is in `yay-x11.txt`. The installed `gocrosshair-debug` package is not
  treated as the application.

## MCSR components

- MCSR Launcher source/data is copied from the live
  `/home/nathan/MCSR/CrossDisplayManager/MCSRlauncher/MCSRLauncher.jar`, with
  its small user options file at `shared/mcsr/launcher/options.json`.
- Ninjabrain Bot `1.5.2` and Paceman Tracker `0.7.2` are copied as the current
  JARs from Waywall resources.
- Selected live PrismLauncher instance data is copied under
  `shared/minecraft/instances/`: `ranked`, `seedqueue`, `x11 ranked`, and
  `1.21.1 ssg`. Runtime logs, worlds, replay caches, generated jars, and
  credentials are deliberately omitted. The launcher directory's downloaded
  assets, libraries, Java runtimes, logs, and launcher-managed instance cache
  are also omitted because they are reproducible runtime data and total about
  15 GB.

## Deliberately omitted local wrappers

- `/home/nathan/.local/bin/obs` is a local OBS wrapper around the packaged OBS
  executable. It is not copied because it is tied to the current machine's
  portal/capture workaround. The repository scripts use the native packaged
  `/usr/bin/obs` command instead.
- `foot-tabbed` and `jay-desktop-launcher` are copied under
  `wayland/helpers/` because the current Jay configuration invokes them
  directly.
- The live `mcsr-update-launcher` helper is deliberately not copied. It is an
  optional updater and currently calls `jar`, which is not present with the
  reference machine's JRE-only Java installation. The setup keeps the
  current launcher JAR and launches it directly.

## Private authentication backup

Reusable launcher authentication is intentionally outside Git and GitHub.
Before using a fresh setup, make a mode-600 offline backup at:

`/home/nathan/MCSR/private-backup/mcsr-setup-auth/`

Copy these exact live files there, preserving their filenames:

- `/home/nathan/.local/share/PrismLauncher/accounts.json`
  -> `PrismLauncher/accounts.json`
- `/home/nathan/MCSR/CrossDisplayManager/MCSRlauncher/launcher/accounts.json`
  -> `MCSRLauncher/accounts.json`

Restore them to their original paths only after the relevant launcher is
installed, and never add the private-backup directory to Git. This task does
not create or copy those credential files.

## Deliberately absent from manifests

- `jay-git`: the active Jay is a local 1.14.0 build, not a pacman/AUR install.
- `polychromatic-git`: the exact local source build is preserved instead of
  silently substituting a newly built AUR revision.
- `obs-plugin-input-overlay-bin`: saved scenes use an OBS browser source and a
  local HTML overlay; no saved scene source uses the plugin's `input-overlay`
  source id. The actual local overlay assets/helper are preserved under
  `shared/obs/input-overlay/` for the full Wayland setup.
- `dotool`: included in `packages/pacman-wayland-lag.txt` because the full
  Wayland input-recorder helper invokes it, and the full Jay startup helper
  may use it for focus. It is deliberately absent from NL Wayland.
