#!/usr/bin/env bash
# Give kitty windows a bspwm border; everything else keeps border_width 0.
width=3

set_border() {
    class=$(bspc query -T -n "$1" 2>/dev/null | jq -r '.client.className // empty')
    [ "$class" = kitty ] && bspc config -n "$1" border_width "$width"
}

for node in $(bspc query -N -n .window); do
    set_border "$node"
done

bspc subscribe node_add | while read -r _ _ _ _ node; do
    set_border "$node"
done
