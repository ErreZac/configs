#!/bin/sh

PROFILE="$(tuned-adm active | awk '{print $4}' | sed s/://)"

if [ "$PROFILE" == "powersave" ]; then
    echo "{\"text\": \"Powersave\", \"class\": \"powersave\", \"percentage\": 0}"
elif [ "$PROFILE" == "balanced" ]; then
    echo "{\"text\": \"Balanced\", \"class\": \"balanced\", \"percentage\": 50}"
elif [ "$PROFILE" == "throughput-performance" ]; then
    echo "{\"text\": \"Performance\", \"class\": \"performance\", \"percentage\": 100}"
fi
