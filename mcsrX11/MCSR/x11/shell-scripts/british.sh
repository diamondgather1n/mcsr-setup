#!/usr/bin/env bash

xmodmap "$HOME/MCSR/x11/xmodmap/british"
"$HOME/MCSR/x11/shell-scripts/i3 config.sh"
killall gocrosshair
