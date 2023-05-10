#!/bin/sh

asusctl -k low;
asusctl profile -P Balanced
xrandr --output eDP-1 --brightness .9;
CURVE="35c:40,47c:60,53c:80,57c:100,61c:130,66c160,70c:180,98c:200"
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f cpu -D $CURVE --enabled false
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f gpu -D $CURVE --enabled false
