#!/bin/sh
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
pgrep -x sxhkd > /dev/null || sxhkd &
pgrep -x picom > /dev/null || picom -b --config ~/.config/picom/config.ini &
~/.config/polybar/launch.sh &
feh --bg-scale ~/Pictures/wallpaper.jpg &
xsetroot -cursor_name left_ptr &
exec bspwm
xrandr --output HDMI-1 --rotate right --mode 2560x1440 --rate 144 --right-of eDP-1
case "$1" in
	bspwm) exec bspwm ;;
	xfce4) exec startxfce4 ;;
	openbox) exec openbox-session ;;
	*) exec bspwm ;;
esac
