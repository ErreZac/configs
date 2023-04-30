#!/usr/bin/env bash
id=$(xdotool search --class scratchterm)

if [ "$id" != "" ]; then
    bspc node "$id" --flag hidden -f
else
    env fish_tmux_autoconnect=false alacritty --class scratchterm&
    bspc rule -a scratchterm sticky=on state=floating hidden=off
fi
