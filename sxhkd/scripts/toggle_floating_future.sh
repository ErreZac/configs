#!/bin/sh
if [ -f /tmp/allfloats ]; then 
  bspc rule -r tail
  rm /tmp/allfloats 
else 
  bspc rule -a "*" state=floating
  touch /tmp/allfloats 
fi
