# Manual Steps And Deliberate Omissions

This repository intentionally does not store private runtime data or large application binaries.

## Not Stored

- Account logins, browser profiles, cookies, OAuth tokens, stream keys, and Discord/GitHub credentials.
- SSH private keys and other private key material.
- OBS streaming credentials and WebSocket passwords.
- Chromebook remote generated TLS certificates and control tokens.
- Minecraft/Microsoft credentials, launcher accounts, worlds, instances, and cache data.
- Large Java/JAR binaries such as Ninjabrain Bot, Paceman Tracker, and MCSR Launcher jars.
- Codex temporary migration scripts under `~/MCSR/temp/`.
- Generic `.bak` files, Codex backup files, logs, caches, crash dumps, and compiled binaries.

## Restore Notes

- Files under `system/etc/keyd/` belong under `/etc/keyd/` and require root to restore.
- The custom XKB source is tracked under `MCSR/wayland/xkb/symbols/mcsr`; the live `~/.config/xkb/symbols/mcsr` is a symlink to that file.
- Waywall currently references JARs under `~/.config/waywall/resources/`; those binaries must be installed separately.
- GoCrosshair's compiled binary is omitted; rebuild it from the tracked source or install it separately.
- The current unmanaged `~/.local/bin/jay.real` binary and local GBM shim are omitted; v0.1 uses the `jay-git` package path and leaves the custom portal/shim work for a later stage.
- OBS/portal permissions and screen-capture behaviour must be revalidated manually on a fresh Jay session.
