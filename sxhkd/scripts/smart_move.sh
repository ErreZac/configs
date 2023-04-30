#!/bin/sh

[ "$#" -eq 1 ] || { echo "Pass only one argument: north,east,south,west"; exit 1; }

# Check if argument is a valid direction.
case "$1" in
	north|east|south|west)
		dir="$1"
		;;
	*)
		echo "Not a valid argument."
		echo "Use one of: north,east,south,west"
		exit 1
		;;
esac

_query_nodes() {
	bspc query -N -n "$@"
}

# Do not operate on floating windows!
[ -z "$(_query_nodes focused.floating)" ] || { echo "Only move tiled windows."; exit 1; }

receptacle="$(_query_nodes 'any.leaf.!window')"

if [ -n "$(_query_nodes "${dir}.!floating")" ]; then
    # if the node in that dir is ok, swap
	bspc node -s "$dir"
elif [ -n "$receptacle" ]; then
    # if there's a receptacle, use it
	bspc node focused -n "$receptacle" --follow
else
    # otherwise, make one and go
	bspc node @/ -p "$dir" -i
    bspc node focused -n $(bspc query -N -n any.leaf.!window) --follow
fi
