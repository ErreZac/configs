#!/bin/sh

asusctl -k off;
xrandr --output eDP-1 --brightness .5;
asusctl profile -P Quiet
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') -d
asusctl fan-curve --mod-profile $(asusctl profile -p | awk '{print $4}') --enabled true
