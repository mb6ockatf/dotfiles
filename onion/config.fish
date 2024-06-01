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
	alias ifconfig='echo "use ip a"'
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
	alias clear='sl -adF; clear'
	alias google-chrome='/usr/bin/google-chrome-stable %U'
	alias sha1='openssl sha1'
	alias echoi='rev'
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
	alias clip='xclip -sel clip'
	alias pwrd='cat /etc/passwd | column -t -s ":"'
	alias bc='bc -l'
	alias h='cat .bash_history | sort | uniq -c | sort -nr'
	alias j='jobs -l'
	alias f="find . | grep "

    # Commands to run in interactive sessions can go here
end
