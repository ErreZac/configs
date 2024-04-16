#!/bin/sh

PROFILE="$(powerprofilesctl | grep "*" | awk '{print $2}' | sed s/://)"

if [ "$PROFILE" == "power-saver" ]; then
    powerprofilesctl set balanced
elif [ "$PROFILE" == "balanced" ]; then
    powerprofilesctl set performance
elif [ "$PROFILE" == "performance" ]; then
    powerprofilesctl set power-saver
fi
