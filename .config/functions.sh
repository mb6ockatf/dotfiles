#!/bin/bash
# functions.sh - addition to .bashrc, with useful bash functions
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
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

statistics() {
	history | awk '{print $2}' | sort | uniq -c | sort -rn
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

wttr() {
	city="$1" && options="$2" && header="Accept-Language: en"
	[ "$options" = "" ] && options="1FnQp"
	curl -H "$header " "wttr.in/$city?$options"
}

rot13() {
	echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

trim() {
	var="$*"
	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"
	echo "$var"
}

hexencode() {
	echo "$@" | xxd -p
}

hexdecode() {
	echo "$@" | xxd -p -r
}

export IS_GCC_HERE=false
if command -v gcc >/dev/null 2>&1
then
	export IS_GCC_HERE=true
fi
export IS_PYTHON3_HERE=false
if command -v python3 >/dev/null 2>&1
then
	export IS_PYTHON3_HERE=true
fi
export IS_NMAP_HERE=false
if command -v nmap >/dev/null 2>&1
then
	export IS_NMAP_HERE=true
fi
export IS_APT_HERE=false
if command -v apt >/dev/null 2>&1
then
	export IS_APT_HERE=true
fi
export IS_PIP3_HERE=false
if command -v pip3 >/dev/null 2>&1
then
	export IS_PIP3_HERE=true
fi
gcc_version() {
	if $IS_GCC_HERE
	then
		printf "%s (latest: GCC 15 as of 06.30.2025)\n" \
			"$(gcc -v 2>&1 | tail -n 1)"
	else
		printf "GCC ain't found\n"
	fi
}
export GCC_VERSION="$(gcc_version)"

python3_version() {
	if $IS_PYTHON3_HERE
	then
		printf "%s (latest: python 3.13.5 as of 06.30.2025)\n" \
			"$(python3 --version)"
	else
		printf "python3 ain't found\n"
	fi
}
export PYTHON3_VERSION="$(python3_version)"

updateos() {
	$IS_APT_HERE && sudo apt update -y && sudo apt full-upgrade -y
	$IS_NMAP_HERE && sudo nmap --script-updatedb
	if [ "$1" == "--with-pip" ] && $IS_PIP3_HERE
	then
		printf "%s pip packages outdated\n" \
			"$(pip3 list --outdated | wc -l)"
	fi
	$IS_GCC_HERE && gcc_version
	$IS_PYTHON3_HERE && python3_version
}
