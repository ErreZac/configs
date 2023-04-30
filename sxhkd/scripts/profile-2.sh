#!/bin/sh

asusctl -k low;
asusctl profile -P Performance
xrandr --output eDP-1 --brightness .9;
CURVE="35c:40,47c:60,53c:80,57c:100,61c:150,66c190,70c:200,98c:220"
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f cpu -D $CURVE --enabled true
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f gpu -D $CURVE --enabled true

