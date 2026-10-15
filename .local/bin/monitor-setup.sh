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

# bspwm needs a moment to add or remove the monitor after xrandr.
sleep 1

names="0001 0010 0011 0100 0101 0110 0111 1000"
for mon in $(bspc query -M --names); do
	# Give any freshly added bspwm monitor the same desktops as the others.
	if [ "$(bspc query -D -m "$mon" --names)" = Desktop ]; then
		bspc monitor "$mon" -d $names
		continue
	fi
	# An unplugged monitor's desktops get appended to this one: fold each
	# extra desktop's windows into the same-numbered desktop, then drop it.
	index=0
	for desk in $(bspc query -D -m "$mon"); do
		index=$((index + 1))
		[ "$index" -gt 8 ] || continue
		target=$(bspc query -D -d "$mon:^$(( (index - 1) % 8 + 1 ))")
		for node in $(bspc query -N -d "$desk" -n .window); do
			bspc node "$node" -d "$target"
		done
		bspc desktop "$desk" -r
	done
done
