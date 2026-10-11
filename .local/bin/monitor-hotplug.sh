#!/bin/sh
# Re-run monitor-setup.sh whenever the HDMI connector state changes.
file=/sys/class/drm/card0-HDMI-A-1/status
last=
while :; do
	now=$(cat "$file" 2>/dev/null)
	if [ "$now" != "$last" ]; then
		sleep 1
		~/.local/bin/monitor-setup.sh
		last=$now
	fi
	sleep 2
done
