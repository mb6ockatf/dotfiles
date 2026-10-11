#!/bin/sh
# ~/.xinitrc - X session for startx; display managers read ~/.xprofile instead
[ -r ~/.xprofile ] && . ~/.xprofile
xsetroot -cursor_name left_ptr
exec bspwm
