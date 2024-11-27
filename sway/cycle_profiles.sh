#!/bin/sh

PROFILE="$(tuned-adm active | awk '{print $4}' | sed s/://)"

if [ "$PROFILE" == "powersave" ]; then
    tuned-adm profile balanced
elif [ "$PROFILE" == "balanced" ]; then
    tuned-adm profile throughput-performance
elif [ "$PROFILE" == "throughput-performance" ]; then
    tuned-adm profile powersave
fi
