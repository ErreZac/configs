#!/bin/sh

PROFILE="$(asusctl profile -p | awk '{print $4}')"

if [ "$PROFILE" == "Quiet" ]; then
    /home/zac/.config/nvim/profiles/profile-1.sh
elif [ "$PROFILE" == "Balanced" ]; then
    /home/zac/.config/nvim/profiles/profile-2.sh
elif [ "$PROFILE" == "Performance" ]; then
    /home/zac/.config/nvim/profiles/profile-0.sh
fi
