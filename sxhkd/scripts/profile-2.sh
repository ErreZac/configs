#!/bin/sh

asusctl -k low;
asusctl profile -P Performance
xrandr --output eDP-1 --brightness .9;
# CURVE="35c:40,47c:60,53c:80,57c:100,61c:150,66c190,70c:200,98c:220"
CURVE="35c:110,47c:140,53c:155,57c:165,61c:175,67c:190,75c:210,93c:255"
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f cpu -D $CURVE --enabled false
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -f gpu -D $CURVE --enabled false

