set -Ux END "\033[0m"
set -Ux BLACK "\033[0;30m"
set -Ux BLACKB "\033[1;30m"
set -Ux WHITE "\033[0;37m"
set -Ux WHITEB "\033[1;37m"
set -Ux RED "\033[0;31m"
set -Ux REDB "\033[1;31m"
set -Ux GREEN "\033[0;32m"
set -Ux GREENB "\033[1;32m"
set -Ux YELLOW "\033[0;33m"
set -Ux YELLOWB "\033[1;33m"
set -Ux BLUE "\033[0;34m"
set -Ux BLUEB "\033[1;34m"
set -Ux PURPLE "\033[0;35m"
set -Ux PURPLEB "\033[1;35m"
set -Ux LIGHTBLUE "\033[0;36m"
set -Ux LIGHTBLUEB "\033[1;36m"
set COMMAND_NUMBER 0

function stats
	history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort \
		| uniq -c | sort -rn | head -30 | less
end

function ex
	if [ -f "$1" ]
		switch $1
			case *.tar.bz2
				tar xjf "$1"
			case *.tar.gz
				tar xzf "$1"
			case *.bz2
				bunzip2 "$1"
			case *.rar
				unrar x "$1"
			case *.gz
				gunzip "$1"
			case *.tar
				tar xf "$1"
			case *.tbz2
				tar xjf	"$1"
			case *.tgz
				tar xzf "$1"
			case *.zip
				unzip "$1"
			case *.Z
				uncompress "$1"
			case *.7z
				7z x "$1"
			case '*'
				echo "'$1' cannot be extracted via ex()"
		end
	else
		echo "'$1' is not a valid file"
		return 22
	end
end

function commit
	set -l TYPE $(gum choose "fix" "feat" "docs" "style" "refactor" "test" \
	"chore" "revert")
	set -l SCOPE $(gum input --placeholder "scope")
	test -n "$SCOPE" && set SCOPE "($SCOPE)"
	set -l SUMMARY $(gum input --value "$TYPE$SCOPE: " --placeholder \
"Summary of this change")
	set -l DESCRIPTION $(gum write --placeholder \
"Details of this change (CTRL+D to finish)")
	gum confirm "Commit changes?" && \
	git commit -m "$SUMMARY" -m "$DESCRIPTION"
end

function fish_prompt
	set COMMAND_NUMBER "$(math $COMMAND_NUMBER + 1)"
 	echo -n "$USER"
 	set_color brblue
 	echo -n "@"
 	set_color brred
 	echo -n "$hostname "
 	set_color brgreen
 	echo -n "$(pwd | sed "s,^$HOME,~,")"
 	set_color brblue
 	echo -n " $COMMAND_NUMBER "
end

if status is-interactive
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
	alias moo='fortune | cowsay | pv -qL 30'
	alias df='df -h'
	alias free='free -h'
	alias ln='ln -i'
	alias cp='cp -i'
	# alias np='nano -w PKGBUILD'
	alias chown='chown --preserve-root'
	alias chmod='chmod --preserve-root'
	alias chgrp='chgrp --preserve-root'
	alias rm='rm -ivI --preserve-root'
	alias ifconfig=ifconfig_help
	alias netstat='ss -v'
	alias iwconfig='iw --version'
	# alias scp="echo 'use $(color::form_output red rsync)'"
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
	alias clear='sl -adF; /usr/bin/clear'
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
	alias exit="echo noexit"
	export PROMPT_COMMAND set_bash_prompt
    # Commands to run in interactive sessions can go here
end
