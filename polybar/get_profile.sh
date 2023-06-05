#!/bin/sh

PROFILE="$(asusctl profile -p | awk '{print $4}')"

if [ "$PROFILE" == "Quiet" ]; then
    echo " "
elif [ "$PROFILE" == "Balanced" ]; then
    echo "  "
elif [ "$PROFILE" == "Performance" ]; then
    echo "   "
fi
