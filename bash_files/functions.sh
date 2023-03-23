#!/usr/bin/env bash

colors() {
	local fg_color bg_color vals seq0
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
	for fg_color in {30..37}; do
		for bg_color in {40..47}; do
			fg_color=${fg_color#37}
			bg_color=${bg_color#40}
			vals="${fg_color:+$fg_color;}${bg_color}"
			vals=${vals%%;}
			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo
		echo
	done
}

ex () {
	if [ -f $1 ]
	then
		case $1 in
			*.tar.bz2)        tar xjf $1   ;;
			*.tar.gz)         tar xzf $1   ;;
			*.bz2)            bunzip2 $1   ;;
			*.rar)            unrar x $1   ;;
			*.gz)             gunzip $1    ;;
			*.tar | *.tar.xz) tar xf $1    ;;
			*.tbz2)           tar xjf $1   ;;
			*.tgz)            tar xzf $1   ;;
			*.zip)            unzip $1     ;;
			*.Z)              uncompress $1;;
			*.7z)             7z x $1      ;;
			*)                echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

light () {
	file="/sys/class/backlight/intel_backlight/brightness"
	current=$(cat "$file")
	new="$current"
	if [ "$1" = "-dec" ]
	then
		new=$(( current - $2 ))
	elif [ "$1" = "-inc" ]
	then
		new=$(( current + $2 ))
	elif [ "$1" = "night" ]
	then
		new=1
	fi
	[[ "$new" -ge 0 ]] || exit
	echo "$new" | sudo tee "$file"
}

