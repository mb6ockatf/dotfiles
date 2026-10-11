#!/usr/bin/env bash
options="Lock\nLogout\nReboot\nShutdown"
chosen=$(echo -e "$options" | rofi -dmenu -p "Power")
case "$chosen" in
	"Lock") slock ;;
	"Logout") bspc quit;;
	"Reboot") loginctl reboot;;
	"Shutdown") loginctl poweroff;;
esac
