#!/bin/sh
if [ "$(asusctl fan-curve -m $(asusctl profile -p | awk '{print $4}') | grep enabled | awk '{print substr($3,1,1)}' | sed -n '1p')" == "t" ]; then 
    echo "" 
else
    echo "" 
fi

#  
