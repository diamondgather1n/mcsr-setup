#!/bin/bash
wmctrl -r :ACTIVE: -b remove,fullscreen
W=1920
H=320
X=0
Y=400

wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H
polychromatic-cli -d mouse --dpi 2000
"$HOME/MCSR/x11/shell-scripts/i3 config.sh"
