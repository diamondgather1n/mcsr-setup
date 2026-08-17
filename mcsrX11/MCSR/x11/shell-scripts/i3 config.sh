#!/bin/bash
KEYWORD="Razer"
KEYD_VIRT="keyd"
MATRIX="0.0625 0 904.6875 0 0.0625 512.8125 0 0 1"

IDS=$(xinput list | grep -iE "$KEYWORD|$KEYD_VIRT" | grep "slave  pointer" | sed -n 's/.*id=\([0-9]*\).*/\1/p')

for id in $IDS; do
    xinput set-prop "$id" 'Coordinate Transformation Matrix' $MATRIX
done

xset r rate 150 200
