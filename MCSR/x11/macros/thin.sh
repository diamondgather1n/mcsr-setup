#!/bin/bash
wmctrl -r :ACTIVE: -b remove,fullscreen
W=320
H=1080
X=800
Y=0

wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H
polychromatic-cli -d mouse --dpi 2000
"$HOME/MCSR/x11/shell-scripts/i3 config.sh"
