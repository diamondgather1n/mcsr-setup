#!/usr/bin/env bash
set -Eeuo pipefail

# mcsrX11.sh will eventually:
# - install shared packages and X11 packages;
# - restore i3, xmodmap, X11 macros, language scripts, and the preserved X11 tree;
# - restore shared keyd, Foot, Zellij, and Micro if retained for X11;
# - later install Minecraft/MCSR components;
# - validate the resulting X11 setup without enabling it from the Wayland setup.

printf '%s\n' 'mcsrX11.sh is currently a setup skeleton; no installation was performed.'
