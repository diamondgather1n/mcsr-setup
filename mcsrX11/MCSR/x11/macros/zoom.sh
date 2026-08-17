#!/bin/bash
wmctrl -r :ACTIVE: -b remove,fullscreen
W=320
H=16384
X=800
Y=$(( (1080 - H) / 2 ))

wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H
polychromatic-cli -d mouse --dpi 300
"$HOME/MCSR/x11/shell-scripts/i3 config.sh"
