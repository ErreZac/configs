#!/bin/sh

bspc node \
    $(bspc query -N -n focused) \
    -n \
    $(bspc query -N -n .leaf.\!window)
