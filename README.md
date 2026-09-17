# mcsr-setup

Reproducible Arch Linux desktop and Minecraft speedrunning setup for a normal,
non-root user. Start from a minimal bootable Arch installation with networking,
`git`, `sudo`, and working package mirrors, then clone this repository and run
one entry point without `sudo`:

```sh
./NLmcsrWL.sh
```

The installer invokes `sudo` only for packages, system configuration, user
group membership, and system services. It also tees full output to
`~/mcsr-setup-<variant>.log` for debugging. Reboot after it completes.

## Variants

| Installer | Desktop | Minecraft instance | Purpose |
| --- | --- | --- | --- |
| `NLmcsrWL.sh` | Jay/Wayland | `waywall` from live `Ranked2` | Minimal diagnostic baseline and primary test target |
| `LmcsrWL.sh` | Jay/Wayland | `waywall` from live `Ranked2` | Fuller comparison configuration |
| `NLmcsrX11.sh` | i3/X11 | `MCSRRanked` from live `Ranked` | Minimal X11 fallback/baseline |
| `LmcsrX11.sh` | i3/X11 | `MCSRRanked` from live `Ranked` | Fuller X11 comparison configuration |

The fuller `L` manifests contain additional desktop helpers. Their presence
does not establish that any individual component causes lag.

## Deployment Map

The checkout remains source data. Installation renders `@HOME@` and `@USER@`
in the destination copy where a format needs absolute paths.

| Repository source | Installed destination |
| --- | --- |
| `wayland/jay/*-config.toml` | `~/.config/jay/config.toml` |
| pinned Jay source and wrapper | `~/.local/bin/jay.real`, `~/.local/bin/jay` |
| `wayland/waywall/*-init.lua` | `~/.config/waywall/init.lua` |
| Waywall resources | `~/.config/waywall/resources/` |
| patched, pinned Waywall source | `~/.local/bin/waywall-ctrl-scroll` |
| `wayland/xkb/symbols/mcsr` | `~/MCSR/wayland/xkb/symbols/mcsr` |
| XKB live link | `~/.config/xkb/symbols/mcsr` |
| `shared/keyd/normal.conf` | `/etc/keyd/normal.conf` |
| Foot and Zellij sources | `~/.config/foot/`, `~/.config/zellij/` |
| shared scripts | `~/.local/bin/` |
| native OBS profile/scenes | `~/.config/obs-studio/` |
| OBS input overlay | `~/.local/share/obs-input-overlay/` |
| OBS image assets | `~/MCSR/CrossDisplayManager/obs images/` |
| MCSRLauncher JAR | `~/MCSR/CrossDisplayManager/MCSRlauncher/` |
| MCSRLauncher options | `~/launcher/options.json` |
| selected Minecraft instance | `~/launcher/instances/waywall` or `~/launcher/instances/MCSRRanked` |
| legacy X11 sources | `~/.config/i3/` and `~/MCSR/x11/` |

Jay keeps the normal desktop `gb,no` layout. Waywall owns the custom `mcsr`
gameplay layout. Native X11 retains its xmodmap implementation. The installed
keyd configuration is limited to the current low-level mouse mappings plus the
current right-control desktop mapping; stale speedrun/F-key mappings are not
restored.

## Applications and Defaults

The manifests install Discord, Helium, MCSRLauncher, Waywall, Spotify, native
OBS Studio with browser support, qpwgraph, pavucontrol, Foot for Wayland,
Waybar, Shotcut, GIMP, imv, mpv, Zellij, Yazi, Micro, fd, ripgrep, and
playerctl. Yazi is the intended file manager; this setup does not install
Thunar, Double Commander, or a full KDE/Xfce desktop.

Rendered MIME defaults use Helium for web links and PDFs, Micro for text/config
files, mpv for audio/video, imv for images/GIFs, and Yazi for directories.

### Wayland Terminal

Super+Enter opens Foot with an independent Zellij session for each window.
`foot` opens a plain shell; `foot-tabbed -e command ...` forwards explicit
commands/options to Foot. The Yazi and Micro desktop helpers open those apps
directly. An existing session can be attached explicitly with `zellij attach`.

| Shortcut | Action |
| --- | --- |
| Ctrl+Shift+T / Ctrl+Shift+W | New / close tab (closing stops its programs) |
| Ctrl+Tab / Ctrl+Shift+Tab | Next / previous tab |
| Ctrl+PageDown / Ctrl+PageUp | Next / previous tab, alternative |
| Alt+1 through Alt+9 | Select tab |
| Ctrl+Shift+C / Ctrl+Shift+V | Copy / paste |
| Shift+mouse drag | Foot selection, including across pane boundaries |
| Mouse wheel / Shift+PageUp or PageDown | Scroll output; Esc returns from keyboard scrolling |
| Ctrl+Shift+F | Search pane output: type, Enter, n/p for matches, Esc to return |
| Ctrl+Shift+E | Open pane scrollback in Micro |
| Ctrl+Shift+Right or Down | Split a pane |
| Alt+arrow | Focus a pane |
| Ctrl+Shift+Y | Dual-pane Yazi tab |
| Ctrl+Shift+Space | Zellij session controls; Esc returns |

Dragging normally selects within a Zellij pane and copies through `wl-copy`.
Jay grants `data-control` only to the installed `wl-copy`/`wl-paste` executables
so these clipboard tools can work without acquiring keyboard focus.
Holding Shift selects through Foot instead. Plain Foot's output search is
Ctrl+Shift+R. Ordinary shell editing keys pass through Zellij's normal mode,
including Ctrl+C/L/R, Ctrl+A/E/B/F, Ctrl+U/K/W, and Alt+B/F.

Arch Bash enables Readline bracketed paste by default. Multiline clipboard
text is inserted for review, preserving newlines, and Enter submits it.
Paste inserts at the cursor: existing prompt text is not cleared or separated
automatically. Cancel an unfinished command with Ctrl+C before pasting a new
block. No shell startup replacement is needed for this behavior.

## Authentication and Hardware

Launcher accounts, Microsoft/Minecraft credentials, Twitch tokens, stream
keys, SoundAlerts URLs, GitHub tokens, and 2FA secrets are deliberately absent.
Sign in manually after installation. PipeWire capture restore tokens are also
machine-specific and are not transferred; select the intended OBS capture
targets on first use.

The reference profile includes a 1920x1080 165 Hz `DP-1` display, an AMD GPU,
and a Razer mouse. CPU microcode and Vulkan drivers are detected at install
time. The Razer DPI helper checks for a matching mouse before applying the
saved setting. The Jay output command can fail harmlessly on another output;
edit the rendered Jay config for a different monitor topology.

## Verification

After reboot, run the read-only verifier with the same variant:

```sh
./verify-install.sh NLmcsrWL.sh
```

It prints `PASS`, `FAIL`, and `WARN` records and exits non-zero when a required
check fails. It does not repair or alter the installation.
