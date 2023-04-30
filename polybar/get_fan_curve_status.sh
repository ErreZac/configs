#!/bin/sh
if [ "$(asusctl fan-curve -m $(asusctl profile -p | awk '{print $4}') | grep enabled | awk '{print substr($3,1,1)}')" == "t" ]; then 
    echo "" 
else
    echo "" 
fi

#  
