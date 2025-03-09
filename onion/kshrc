#!/usr/bin/env bash
iatest=$(expr index "$-" i)
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
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

stats() {
	history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort \
		| uniq -c | sort -rn | head -30 | less
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
		echo "'$1' is not a valid file"
		return 22
	fi
}

light() {
	local file="/sys/class/backlight/intel_backlight/brightness"
	if [[ ! -f $file ]]; then
		echo "intel_backlight settings are not available"
		return 2
	fi
	local current=$(cat "$file")
	local new="$current"
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

commit() {
	local TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" \
	"chore" "revert")
	local SCOPE=$(gum input --placeholder "scope")
	test -n "$SCOPE" && SCOPE="($SCOPE)"
	local SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder \
"Summary of this change")
	local DESCRIPTION=$(gum write --placeholder \
"Details of this change (CTRL+D to finish)")
	gum confirm "Commit changes?" && \
	git commit -m "$SUMMARY" -m "$DESCRIPTION"
}

set_bash_prompt() {
	local LAST_RESULT=$?
	local DIVIDER="\[\e[30;1m\]"
	local COLOR_CMDCOUNT="\[\e[32;1m\]"  # green bold
	local COLOR_USERNAME="\[\e[37;0m\]"  # white
	local COLOR_USERHOSTAT="\[\e[36;1m\]"  # lightblueb
	local COLOR_HOSTNAME="\[\e[35;1m\]"  # purple bold
	local COLOR_GITBRANCH="\[\e[33;0m\]"  # yellow
	local COLOR_VENV="\[\e[33;1m\]"  # yellow bold
	local COLOR_PATH_OK="\[\e[32;1m\]"  # green bold
	local COLOR_PATH_ERR="\[\e[31;1m\]"  # red bold
	local COLOR_NONE="\[\e[0m\]"  # end
	local PATH_COLOR GIT_IS_AVAILABLE GIT_BRANCH git_answer
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
		PS1="${PS1}:${COLOR_VENV}$(basename "$VIRTUAL_ENV")${DIVIDER}"
	fi
	PS1="${PS1}][${DIVIDER}${COLOR_USERNAME}\u${COLOR_USERHOSTAT}"
	PS1+="@${COLOR_HOSTNAME}\h${DIVIDER}]${COLOR_NONE} "
}

mcd() {
        [ -d "$1" ] || mkdir "$1"
        cd "$1" && pwd
}

wttr() {
	local city="$1"
	local options="$2"
	local header="Accept-Language: en"
	[[ "$options" -eq "" ]] && options="1FnQp"
	curl -H "$header " "wttr.in/$city?$options"
}

clock() {
	watch -xtc echo "$(date '+%D %T' | toilet -f term -F border --gay)"
}

ftext() {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. \
	# grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

mvg() {
	if [ -d "$2" ]; then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$3"
	fi
}

viewlines () {
	sed -n "$1,$2p" "$3"
}

bashrc() {
	reload=true
	. ~/.bashrc > /dev/null 2>&1
	reload=false
}

cpg() {
	if [ -d "$2" ]; then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

repc() {
	for ((i = 1; i < $2; i++)); do
		echo -n "$1"
	done
}

pwdtail() {
	pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

up() {
	local d=""
	local limit=$1
	for ((i=1 ; i <= limit ; i++)); do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	[[ -z "$d" ]] && d=..
	cd "$d"
}

distribution() {
	local dtype="unknown"
	if [[ -r /etc/rc.d/init.d/functions ]]; then
		. /etc/rc.d/init.d/functions
		[[ zz`type -t passed 2>/dev/null` == "zzfunction" ]] && dtype="redhat"
	elif [[ -f /etc/arch-release ]]; then
		dtype="arch"
	elif [[ -r /etc/rc.status ]]; then
		. /etc/rc.status
		[[ zz`type -t rc_reset 2>/dev/null` == "zzfunction" ]] && dtype="suse"
	elif [[ -r /lib/lsb/init-functions ]]; then
		. /lib/lsb/init-functions
		[[ zz`type -t log_begin_msg 2>/dev/null` == "zzfunction" ]] && \
			dtype="debian"
	elif [[ -r /etc/init.d/functions.sh ]]; then
		. /etc/init.d/functions.sh
		[[ zz`type -t ebegin 2>/dev/null` == "zzfunction" ]] && dtype="gentoo"
	elif [[ -s /etc/mandriva-release ]]; then
		dtype="mandriva"
	elif [[ -s /etc/slackware-version ]]; then
		dtype="slackware"
	fi
	echo "$dtype"
}

ver() {
	local dtype="$(distribution)"
	if [[ "$dtype" == "redhat" ]]; then
		if [[ -s /etc/redhat-release ]]; then
			cat /etc/redhat-release && uname -a
		else
			cat /etc/issue && uname -a
		fi
	elif [[ "$dtype" == "suse" ]]; then
		cat /etc/SuSE-release
	elif [[ "$dtype" == "debian" ]]; then
		lsb_release -a
	elif [[ "$dtype" == "gentoo" ]]; then
		cat /etc/gentoo-release
	elif [[ "$dtype" == "mandriva" ]]; then
		cat /etc/mandriva-release
	elif [[ "$dtype" == "slackware" ]]; then
		cat /etc/slackware-version
	else
		if [[ -s /etc/issue ]]; then
			cat /etc/issue
		else
			echo "Error: Unknown distribution"
			exit 1
		fi
	fi
}

apachelog() {
	if [[ -f /etc/httpd/conf/httpd.conf ]]; then
		cd /var/log/httpd && \
			ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
	else
		cd /var/log/apache2 && \
			ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
	fi
}

apacheconfig() {
	if [[ -f /etc/httpd/conf/httpd.conf ]]; then
		sedit /etc/httpd/conf/httpd.conf
	elif [[ -f /etc/apache2/apache2.conf ]]; then
		sedit /etc/apache2/apache2.conf
	else
		echo "Error: Apache config file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate httpd.conf && locate apache2.conf
	fi
}

phpconfig() {
	if [[ -f /etc/php.ini ]]; then
		sedit /etc/php.ini
	elif [[ -f /etc/php/php.ini ]]; then
		sedit /etc/php/php.ini
	elif [[ -f /etc/php5/php.ini ]]; then
		sedit /etc/php5/php.ini
	elif [[ -f /usr/bin/php5/bin/php.ini ]]; then
		sedit /usr/bin/php5/bin/php.ini
	elif [[ -f /etc/php5/apache2/php.ini ]]; then
		sedit /etc/php5/apache2/php.ini
	else
		echo "Error: php.ini file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate php.ini
	fi
}

mysqlconfig() {
	if [[ -f /etc/my.cnf ]]; then
		sedit /etc/my.cnf
	elif [[ -f /etc/mysql/my.cnf ]]; then
		sedit /etc/mysql/my.cnf
	elif [[ -f /usr/local/etc/my.cnf ]]; then
		sedit /usr/local/etc/my.cnf
	elif [[ -f /usr/bin/mysql/my.cnf ]]; then
		sedit /usr/bin/mysql/my.cnf
	elif [[ -f ~/my.cnf ]]; then
		sedit ~/my.cnf
	elif [[ -f ~/.my.cnf ]]; then
		sedit ~/.my.cnf
	else
		echo "Error: my.cnf file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate my.cnf
	fi
}

rot13() {
	if [[ $# -eq 0 ]]; then
		tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	else
		echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	fi
}

trim() {
	local var=$@
	var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace chars
	var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace chars
	echo -n "$var"
}

folderssort() {
	find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn
}

ls_help() {
cat << End
ls -Al  # show hidden files
ls -lX --ignore-backups  # sort by extension (ls -lXB)
ls -lSr  # sort by size
ls -lcr  # sort by change time
ls -lur  # sort by access time
ls -l --recursive  # recursive (ls -lR)
ls -ltr  # sort by date
ls -l | more'  # pipe through 'more'
ls -xA  # wide listing format
ls -ls  # long listing format
ls -lp  # alphabetical sort
ls -l | egrep -v '^d'"  # files only (remove backslashes)
ls -l | egrep '^d'"  # directories only (remove backslashes)
End
}

ping_help() {
cat << End ping='ping -c 5' fastping='ping -c 100 -i 0.2' ping8="ping 8.8.8.8"
End
}

chmod_help() {
cat << End
chmod a+x chmod -R 000 chmod -R 644 chmod -R 666 chmod -R 755 chmod -R 777
End
}

moo() {
	fortune | cowsay
}

# alias mktar='tar -cvf'
# alias mkbz2='tar -cvjf'
# alias mkgz='tar -cvzf'
# alias untar='tar -xvf'
# alias unbz2='tar -xvjf'
# alias ungz='tar -xvzf'
# alias psmem='ps auxf | sort -nr -k 4'
# alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# alias pscpu='ps auxf | sort -nr -k 3'
# alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias less="less --use-color"
alias more=less
alias ls='ls -Fh --color=auto'
alias grep='grep --colour=auto'
alias egrep='grep -E'
alias fgrep='grep -F'
alias cal="cal | pv -qL 10"
alias todo="todo.sh -@ -+ -c -t -v"
alias shellcheck='shellcheck -C'
alias cowsay='cowsay -d -W 80'
alias df='df -h'
alias free='free -h'
alias ln='ln -i'
alias cp='cp -i'
# alias np='nano -w PKGBUILD'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias rm='rm -ivI --preserve-root'
alias netstat='ss -v'
alias iwconfig='iw --version'
alias dig='drill -v'
alias arp='echo "arp -> ip n"'
alias nslookup='echo "nslookup -> drill or host"'
alias iptunnel='echo "iptunnel -> ip t"'
alias ipmaddr='echo "ipmaddr -> ip maddr"'
alias nameif='echo "nameif -> ip l"'
alias route='echo "route -> ip r"'
alias poweroff='systemctl poweroff'
alias halt='systemctl halt'
alias reboot='systemctl reboot'
alias clear='sl -adF; clear'
alias google-chrome='/usr/bin/google-chrome-stable %U'
alias mkdir='mkdir -pv'
alias meminfo='free -l'
alias mount='mount | column -t'
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias wget='wget -c'
alias bc='bc -l'

alias pwrd='cat /etc/passwd | column -t -s ":"'
alias clip='xclip -sel clip'
alias h='cat .bash_history | sort | uniq -c | sort -nr'
alias j='jobs -l'
alias f="find . | grep "
[ -d "$HOME/.atom" ] && alias atom="~/.atom/atom &"
export CLICOLOR=1
export QT_SELECT=4
command -v pyenv >/dev/null && export PYENV_ROOT="$HOME/.pyenv"
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND=set_bash_prompt
export BROWSER=/usr/bin/chromium
export EDITOR=vim
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)  # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)  # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)  # yellowonblue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)  # white
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1  # For Konsole and Gnome-terminal
command -v pyenv >/dev/null && export PATH="$PYENV_ROOT/bin:$PATH" && \
	eval "$(pyenv init -)"
[[ "$(whoami)" != "root" && "$reload" != "true" ]] && moo
# rate.sx
# parrotsay
# rickroll: https://github.com/keroserene/rickrollrc
# curl -s -L \
# https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash
# curl -s -L https://bit.ly/3zvELNz | bash
