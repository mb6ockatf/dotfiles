#!/bin/sh
# Configure the external HDMI monitor (rotated, right of eDP-1) or turn it off.
# Tries 144 Hz, then 120 Hz, then the monitor's preferred mode.
out=HDMI-1
status=$(cat /sys/class/drm/card0-HDMI-A-1/status 2>/dev/null)

if [ "$status" = connected ]; then
	xrandr --output "$out" --rotate right --mode 2560x1440 --rate 144 --right-of eDP-1 ||
	xrandr --output "$out" --rotate right --mode 2560x1440 --rate 120 --right-of eDP-1 ||
	xrandr --output "$out" --rotate right --auto --right-of eDP-1
else
	xrandr --output "$out" --off
fi

# Give any freshly added bspwm monitor the same desktops as the others.
for mon in $(bspc query -M --names); do
	if [ "$(bspc query -D -m "$mon" --names)" = Desktop ]; then
		bspc monitor "$mon" -d 0001 0010 0011 0100 0101 0110 0111 1000
	fi
done
