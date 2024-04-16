#!/bin/sh

PROFILE="$(powerprofilesctl | grep "*" | awk '{print $2}' | sed s/://)"

if [ "$PROFILE" == "power-saver" ]; then
    echo " "
elif [ "$PROFILE" == "balanced" ]; then
    echo "  "
elif [ "$PROFILE" == "performance" ]; then
    echo "   "
fi
