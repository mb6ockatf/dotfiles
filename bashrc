#!/usr/bin/env bash
# ^datetime^ | https://github.com/mb6ockatf/dotfiles
# ~/.bashrc

readonly END="\033[0m"
readonly BLACK="\033[0;30m"
readonly BLACKB="\033[1;30m"
readonly WHITE="\033[0;37m"
readonly WHITEB="\033[1;37m"
readonly RED="\033[0;31m"
readonly REDB="\033[1;31m"
readonly GREEN="\033[0;32m"
readonly GREENB="\033[1;32m"
readonly YELLOW="\033[0;33m"
readonly YELLOWB="\033[1;33m"
readonly BLUE="\033[0;34m"
readonly BLUEB="\033[1;34m"
readonly PURPLE="\033[0;35m"
readonly PURPLEB="\033[1;35m"
readonly LIGHTBLUE="\033[0;36m"
readonly LIGHTBLUEB="\033[1;36m"


###############################################################################
# repeat character $1 $2 times
# arguments: $1 character, $2 number
# output: $2 characters
###############################################################################
repeat_char() {
	for ((i = 1; i < $2; i++)); do
		echo -n "$1"
	done
}

###############################################################################
# format $2 message so it is $1 color
# arguments: []
# output: colorful message
# return: 2 if wrong color
###############################################################################
color::form_output() {
	if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]] || [[ -z "$1" ]]; then
		name="color::form_output"
		echo -e "apply color to any text"
		echo -e "USAGE"
		echo -e "- show this message (default)"
		echo -e "\t $name [-h, --help]"
		echo -e "- get colored message"
		echo -e "\t $name color message"
		repeat_char - 80
		echo "by @mb6ockatf, Mon 08 May 2023 09:05:30 PM MSK"
		return 0
	fi
	local color="$1" message="$2"
	case "$color" in
		black)      color="${BLACK}"      ;;
		blackb)     color="${BLACKB}"     ;;
		white)      color="${WHITE}"      ;;
		whiteb)     color="${WHITEB}"     ;;
		red)        color="${RED}"        ;;
		redb)       color="${REDB}"       ;;
		green)      color="${GREEN}"      ;;
		greenb)     color="${GREENB}"     ;;
		yellow)     color="${YELLOW}"     ;;
		yellowb)    color="${YELLOWB}"    ;;
		blue)       color="${BLUE}"       ;;
		blueb)      color="${BLUEB}"      ;;
		purple)     color="${PURPLE}"     ;;
		purpleb)    color="${PURPLEB}"    ;;
		lightblue)  color="${LIGHTBLUE}"  ;;
		lightblueb) color="${LIGHTBLUEB}" ;;
		*)          return 2              ;;
	esac
	echo -e "${color}${message}${END}"
}

###############################################################################
# print colors table (backgrounds & foregrounds). useful for choosing colors
# output: colorful message
###############################################################################
color::color_table() {
	T='gYw'
	echo -e "\n                 40m     41m     42m     43m\
	44m     45m     46m     47m";
	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
	    '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
	    '  36m' '1;36m' '  37m' '1;37m'; do
		FG=${FGs// /}
		echo -en " $FGs \033[$FG  $T  "
		for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
			echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m"
		done
		echo
	done
  echo
}


###############################################################################
# print full colorful table (may require much resources for rendering)
# output: colors table
###############################################################################
color::colorful() {
	for x in {0..8}; do 
    	for fg in {30..37}; do 
        	for bg in {40..47}; do 
            	echo -ne "\e[$x;$fg;$bg""m\\\e[$x;$fg;$bg""m\e[0;37;40m "
        	done
        	echo
    	done
	done
	echo ""
}

###############################################################################
# extract archieve files
# arguments: $1 - archive name
# output: corresponding to archive type
# return: 22 if not a valid file was passed
###############################################################################
ex() {
	if [ -f "$1" ]; then
		case $1 in
			*.tar.bz2)   tar xjf    "$1";;
			*.tar.gz)    tar xzf    "$1";;
			*.bz2)       bunzip2    "$1";;
			*.rar)       unrar x    "$1";;
			*.gz)        gunzip     "$1";;
			*.tar)       tar xf     "$1";;
			*.tbz2)      tar xjf    "$1";;
			*.tgz)       tar xzf    "$1";;
			*.zip)       unzip      "$1";;
			*.Z)         uncompress "$1";;
			*.7z)        7z x "$1"      ;;
			*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
		return 22
	fi
}

###############################################################################
# change screen light if intel_backlight settings are present. requires sudo
# arguments: [night | -inc VALUE | -dec VALUE]
# output: nothing
# return: 2 if backlight config is not available
###############################################################################
light() {
	file="/sys/class/backlight/intel_backlight/brightness"
	if [[ ! -f $file ]]; then
		echo "intel_backlight settings are not available"
		return 2
	fi
	current=$(cat "$file")
	new="$current"
	if [ "$1" = "-dec" ]; then
		new=$(( current - $2 ))
	elif [ "$1" = "-inc" ]; then
		new=$(( current + $2 ))
	elif [ "$1" = "night" ]; then
		new=1
	fi
	[[ "$new" -ge 0 ]] || exit
	echo "$new" | sudo tee "$file"
}

###############################################################################
# create neat commits with gum. works in interactive mode
# no arguments required
###############################################################################
commit() {
	TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" \
	"chore" "revert")
	SCOPE=$(gum input --placeholder "scope")
	# Since the scope is optional, wrap it in parentheses if it has a value.
	test -n "$SCOPE" && SCOPE="($SCOPE)"
	# Pre-populate the input with the type(scope): so that the user may
	# change it
	SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder \
"Summary of this change")
	DESCRIPTION=$(gum write --placeholder \
"Details of this change (CTRL+D to finish)")
	gum confirm "Commit changes?" && \
	git commit -m "$SUMMARY" -m "$DESCRIPTION"
}

###############################################################################
# create colorful bash prompt message
# to actually implement this bash prompt, do:
#	export PROMPT_COMMAND=set_bash_prompt
# no arguments required
# output: sets PS1 value
###############################################################################
set_bash_prompt() {
	LAST_RESULT=$?
	DIVIDER="\[\e[30;1m\]"
	COLOR_CMDCOUNT="\[\e[32;1m\]"    # green bold
	COLOR_USERNAME="\[\e[37;0m\]"    # white
	COLOR_USERHOSTAT="\[\e[36;1m\]"  # lightblueb
	COLOR_HOSTNAME="\[\e[35;1m\]"    # purple bold
	COLOR_GITBRANCH="\[\e[33;0m\]"   # yellow
	COLOR_VENV="\[\e[33;1m\]"        # yellow bold
	COLOR_PATH_OK="\[\e[32;1m\]"     # green bold
	COLOR_PATH_ERR="\[\e[31;1m\]"    # red bold
	COLOR_NONE="\[\e[0m\]"           # end
	if [ $LAST_RESULT -eq 0 ]; then
		PATH_COLOR="$COLOR_PATH_OK"
	else
		PATH_COLOR="$COLOR_PATH_ERR"
	fi
	PS1="\n${DIVIDER}"
	PS1="${PS1}[${PATH_COLOR}\w${DIVIDER}"
	PS1="${PS1}:${COLOR_CMDCOUNT}\#${DIVIDER}"
	GIT_IS_AVAILABLE=$(git --version 2>&1 >/dev/null ; echo $?)
	if [ "$GIT_IS_AVAILABLE" -eq 0 ]; then
		git_answer=$(git rev-parse --is-inside-work-tree 2>&1 >/dev/null)
		if [ "$git_answer" = "" ]; then
			GIT_BRANCH=$(git symbolic-ref --short HEAD)
			PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${DIVIDER}"
		fi
	fi
	if [ -n "$VIRTUAL_ENV" ]; then
		PS1="${PS1}:${COLOR_VENV}$(basename \""$VIRTUAL_ENV"\")${DIVIDER}"
	fi
	PS1="${PS1}]"
	PS1+="\n[${DIVIDER}"
	PS1+="${COLOR_USERNAME}\u${COLOR_USERHOSTAT}"
	PS1+="@${COLOR_HOSTNAME}\h${DIVIDER}]"
	PS1+="${COLOR_NONE} "
}

alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias np='nano -w PKGBUILD'
alias more=less
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias py='python3'
alias pip='python3 -m pip'
alias vi='vim'
alias google-chrome='/usr/bin/google-chrome-stable %U'
alias status='git status'
alias pull='git pull'
alias push='git push'
alias add='git add'
alias ls='ls --color=auto'
[ -d "$HOME/.atom" ] && alias atom="~/.atom/atom &"
shopt -s 'checkwinsize'
shopt -s 'expand_aliases'
shopt -s histappend
export QT_SELECT=4
export PYENV_ROOT="$HOME/.pyenv"
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND=set_bash_prompt
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
