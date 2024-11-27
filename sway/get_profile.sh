#!/bin/sh

PROFILE="$(tuned-adm active | awk '{print $4}' | sed s/://)"

if [ "$PROFILE" == "powersave" ]; then
    echo " "
elif [ "$PROFILE" == "balanced" ]; then
    echo "  "
elif [ "$PROFILE" == "throughput-performance" ]; then
    echo "   "
fi
