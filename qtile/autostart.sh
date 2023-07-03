#! /bin/sh

picom &
nitrogen --restore
setxkbmap -option caps:escape
nm-applet &
blueman-applet &
conky &
asusctltray &
