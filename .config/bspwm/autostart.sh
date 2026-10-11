#!/bin/sh
sleep 3
firefox -P "management" --class "firefox-management" -no-remote &
sleep 2
firefox -P "default-esr" --class "firefox-default" -no-remote &
sleep 2
firefox -P "software engineering" --class "firefox-SE" -no-remote &
sleep 2
kitty --class scratchpad --title scratchpad &
sleep 2
bspc node "$(xdotool search --class scratchpad | head -1)" -g hidden=on
