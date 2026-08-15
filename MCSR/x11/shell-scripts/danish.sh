#!/usr/bin/env bash

xmodmap "$HOME/MCSR/x11/xmodmap/danish"
"$HOME/MCSR/x11/shell-scripts/i3 config.sh"
killall gocrosshair
"$HOME/gocrosshair/gocrosshair" &
