#!/usr/bin/bash
shopt -s histappend checkhash;
set -o posix;

END="\033[0m"
BLACK="\033[0;30m"
BLACKB="\033[1;30m"
WHITE="\033[0;37m"
WHITEB="\033[1;37m"
RED="\033[0;31m"
REDB="\033[1;31m"
GREEN="\033[0;32m"
GREENB="\033[1;32m"
YELLOW="\033[0;33m"
YELLOWB="\033[1;33m"
BLUE="\033[0;34m"
BLUEB="\033[1;34m"
PURPLE="\033[0;35m"
PURPLEB="\033[1;35m"
LIGHTBLUE="\033[0;36m"
LIGHTBLUEB="\033[1;36m"
separator="-----------------------------------------------------------------";
separator="${separator}-----------"

statistics () {
	history | awk '{print $2}' | sort | uniq -c | sort -rn
}
color_form_output() {
	color="$1"
	message="$2"
	case "$color" in
		black) color="${BLACK}" ;;
		blackb) color="${BLACKB}" ;;
		white) color="${WHITE}" ;;
		whiteb) color="${WHITEB}" ;;
		red) color="${RED}" ;;
		redb) color="${REDB}" ;;
		green) color="${GREEN}" ;;
		greenb) color="${GREENB}" ;;
		yellow) color="${YELLOW}" ;;
		yellowb) color="${YELLOWB}" ;;
		blue) color="${BLUE}"  ;;
		blueb) color="${BLUEB}" ;;
		purple) color="${PURPLE}" ;;
		purpleb) color="${PURPLEB}" ;;
		lightblue) color="${LIGHTBLUE}" ;;
		lightblueb) color="${LIGHTBLUEB}" ;;
		*) return 2 ;;
	esac
	printf '%b%b%b' "$color" "$message" "$END"
}

ex() {
	if [ -f "$1" ]; then
		case $1 in
			*.tar.bz2) tar xjf "$1";;
			*.tar.gz) tar xzf "$1";;
			*.bz2) bunzip2 "$1";;
			*.rar) unrar x "$1";;
			*.gz) gunzip "$1";;
			*.tar) tar xf "$1";;
			*.tbz2) tar xjf	"$1";;
			*.tgz) tar xzf "$1";;
			*.zip) unzip "$1";;
			*.Z) uncompress "$1";;
			*.7z) 7z x "$1" ;;
			*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file" && return 22
	fi
}

setprompt() {
	LAST_RESULT="$?"
	DIVIDER="\[\e[30;1m\]"
	COLOR_CMDCOUNT="\[\e[32;1m\]"
	COLOR_USERNAME="\[\e[37;0m\]"
	COLOR_USERHOSTAT="\[\e[36;1m\]"
	COLOR_HOSTNAME="\[\e[35;1m\]"
	COLOR_GITBRANCH="\[\e[33;0m\]"
	COLOR_VENV="\[\e[33;1m\]"
	COLOR_PATH_OK="\[\e[32;1m\]"
	COLOR_PATH_ERR="\[\e[31;1m\]"
	COLOR_NONE="\[\e[0m\]"
	[ $LAST_RESULT -eq 0 ] && PATH_COLOR="$COLOR_PATH_OK" \
		|| PATH_COLOR="$COLOR_PATH_ERR"
	PS1="${DIVIDER}[${PATH_COLOR}\w${DIVIDER}"
	PS1="${PS1}:${COLOR_CMDCOUNT}\#${DIVIDER}"
	GIT_IS_AVAILABLE=$(git --version 2>&1 >/dev/null ; echo $?)
	if [ "$GIT_IS_AVAILABLE" -eq 0 ]; then
		git_answer=$(git rev-parse --is-inside-work-tree 2>&1 \
			>/dev/null)
		if [ "$git_answer" = "" ]; then
			GIT_BRANCH=$(git symbolic-ref --short HEAD)
			PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${DIVIDER}"
		fi
	fi
	[ -n "$VIRTUAL_ENV" ] && \
		PS1="${PS1}:${COLOR_VENV}$(basename "$VIRTUAL_ENV")${DIVIDER}"
	PS1="${PS1}][${DIVIDER}${COLOR_USERNAME}\u${COLOR_USERHOSTAT}"
	PS1="${PS1}@${COLOR_HOSTNAME}\h${DIVIDER}]${COLOR_NONE} "
}


wttr() {
	city="$1" && options="$2" && header="Accept-Language: en"
	[ "$options" = "" ] && options="1FnQp"
	curl -H "$header " "wttr.in/$city?$options"
}

rot13() {
	if [ "$#" -eq 0 ]
	then
		tr 'a-mn-zA-MN-Z' 'n-za-mN-ZA-M'
	else
		echo "$@" | tr 'a-mn-zA-MN-Z' 'n-za-mN-ZA-M'
	fi
}

trim() {
	var="$*"
	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"
	echo "$var"
}

alias chown='chown --preserve-root' chmod='chmod --preserve-root' \
	chgrp='chgrp --preserve-root' rm='rm -ivI --preserve-root'

export POSIXLY_CORRECT=true CLICOLOR=1 \
	PATH="/home/mb6ockatf/.local/bin:$PATH" HISTFILESIZE=20000 \
	HISTCONTROL=ignoreboth:erasedups PROMPT_COMMAND=setprompt \
	EDITOR=nvim GROFF_NO_SGR=1  # For Konsole and Gnome-terminal

