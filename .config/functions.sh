#!/usr/bin/env bash
color_form_output()
{
	color="$1" message="$2"
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
		blue) color="${BLUE}" ;;
		blueb) color="${BLUEB}" ;;
		purple) color="${PURPLE}" ;;
		purpleb) color="${PURPLEB}" ;;
		lightblue) color="${LIGHTBLUE}" ;;
		lightblueb) color="${LIGHTBLUEB}" ;;
		*) return 2 ;;
	esac
	printf '%b%b%b' "$color" "$message" "$END"
}

trim()
{
	var="$*"
	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"
	echo "$var"
}


basename()
{
	printf 'Consider using parameter expansion instead (up to x10 faster)\n'
	cat << EOF
for file in *.txt
do
	basename="\${file##*/}"	# Remove path
	basename="\${basename\%.*}"	# Remove extension
	dirname="\${file\%/*}"	# Extract directory
	extension="\${file##*.}"	# Extract extension
done
EOF
	return 1
}


cppf()
{
	cpp -P "${1}" |
		sed -f ~/.config/cppcleanup.sed |
		source-highlight --failsafe -s "${2}" -f esc256 \
			--style-file=esc256.style -o 'STDOUT' |
		less -NRi
}

function make {
  case " $* " in
    *" check "*)
      command make "$@" 2>&1 | sed \
        -e "s/^pass .*/${FGGREEN}&${END}/" \
        -e "s/^All [0-9]* tests passed\.$/${FGGREEN}&${END}/" \
        -e "s/^FAIL .*/${FGRED}&${END}/" \
        -e "s/^[0-9]* of [0-9]* tests failed\.$/${FGRED}&${END}/" ;;
    *) command make "$@" ;;
  esac
}

