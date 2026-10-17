#!/bin/sh
sleep 3
bspc rule -a firefox-esr -o desktop='^1' follow=on
firefox -P "management" -no-remote &
sleep 2
kitty --class scratchpad --title scratchpad &
sleep 2
bspc node "$(xdotool search --class scratchpad | head -1)" -g hidden=on
