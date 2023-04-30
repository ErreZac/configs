#!/bin/sh

PROFILE="$(asusctl profile -p | awk '{print $4}')"

STATUS="$(asusctl fan-curve -m $PROFILE | grep enabled | awk '{print $3}')"

if [ "$STATUS" == "true" ]; then
    asusctl fan-curve -m $PROFILE -e false
elif [ "$STATUS" == "false" ]; then
    asusctl fan-curve -m $PROFILE -e true
fi
