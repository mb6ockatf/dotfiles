#!/usr/bin/env bash
if [ -x /usr/bin/dircolors ]
then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" ||
		eval "$(dircolors -b)"
fi
S='--preserve-root' C='--color=auto' qst='-c --quiet --status --strict'
I='--exclude-dir={.git,node_modules,.venv,__pycache__,build,target,.cache,.svn,.hg}'
ls_basic='--color=auto -hGF --group-directories-first'
# coreutils
alias chown="chown ${S}" chmod="chmod ${S}" chgrp="chgrp ${S}" rm="/usr/bin/rm -iI ${S}"
alias ls="/usr/bin/ls ${ls_basic}"
alias lS="/usr/bin/ls ${ls_basic} -r"
alias la="/usr/bin/ls ${ls_basic} -A"
alias lA="/usr/bin/ls ${ls_basic} -Ar"
alias lt="/usr/bin/ls ${ls_basic} -t"
alias lT="/usr/bin/ls ${ls_basic} -ltr"
alias ll="/usr/bin/ls ${ls_basic} -o"
alias lL="/usr/bin/ls ${ls_basic} -or"
alias lx="/usr/bin/ls ${ls_basic} -oX"
alias lX="/usr/bin/ls ${ls_basic} -oXr"
alias ld="/usr/bin/ls ${ls_basic} -d */"
alias lD="/usr/bin/ls ${ls_basic} -r -d */"
alias l1="/usr/bin/ls ${ls_basic} -1"
alias lU="/usr/bin/ls ${ls_basic} -UAF"
alias lla="/usr/bin/ls ${ls_basic} -lA"
alias basenc="basenc ${S}" dir="dir -hGU ${C}" vdir="vdir -hGU ${C}"
alias mkdir='mkdir -p' date='/usr/bin/date -u' mkdtemp='mktemp -d' mkstemp='mktemp'
alias who='who -HT' fmt='fmt -u' nl='nl -b a'
alias shuf='shuf --random-source=/dev/urandom' factor='factor -h'
alias pathchk='pathchk --portability' errno='errno -ls'
alias df='df -h' du='du -h' top="top -u ${USER}"
alias tree='tree --gitignore'

za() {
	zathura "$@" > /dev/null 2>&1 & disown
}

# scripting
alias awk='awk --posix' python3='python3 -q' sed='sed --posix'
alias julia='julia -O3 --banner=no --color=yes --depwarn=error --warn-overwrite=yes --inline=no'
alias a68g='a68g --strict --pedantic -O3' apl="apl -q --Color"
# archive
alias xz='/usr/bin/xz -e'
alias bzip2='/usr/bin/bzip2 --best'
alias unzip='/usr/bin/unzip -q'
alias unrar='/usr/bin/unrar-free'
# grep
alias grep="grep ${C} ${I}"
alias fgrep="grep -F ${C} ${I}"
alias egrep="grep -E ${C} ${I}"
alias rgrep="grep -r ${C} ${I}"

unalias find 2> /dev/null
find() {
	local -a opts=() paths=()
	local a
	while (($#)) && [[ $1 == -[HLP] || $1 == -O* || $1 == -D ]]
	do
		[[ $1 == -D ]] && { opts+=("$1"); shift; }
		opts+=("$1"); shift
	done
	while (($#)) && [[ $1 != -* && $1 != '(' && $1 != '!' ]]
	do
		paths+=("$1"); shift
	done
	((${#paths[@]})) || paths=(.)
	local -a expr=(-print)
	if (($#))
	then
		expr=(\( "$@" \) -print)
		for a
		do
			case $a in
			-print | -print0 | -printf | -fprint | -fprint0 | -fprintf | -ls | -fls | \
				-exec | -execdir | -ok | -okdir | -delete | -quit)
				expr=(\( "$@" \))
				break
				;;
			esac
		done
	fi
	command find "${opts[@]}" "${paths[@]}" -xdev \( -name .venv -o -name .deps \
		-o -name plugged -o -name .ipynb_checkpoints -o -name node_modules \
		-o -name __pycache__ \) \
		-prune -o "${expr[@]}"
}
# checksums
alias md5checksum="md5sum ${qst}" sha1checksum="sha1sum ${qst}"
alias sha224checksum="sha224sum ${qst}" sha256checksum="sha256sum ${qst}"
alias sha384checksum="sha384sum ${qst}" sha512checksum="sha512sum ${qst}"
alias b2checksum="b2sum ${qst}"
# editors
alias emacs='emacs -nw'
ed() {
	rlwrap -crq '/|' -H "$HOME/.ed_history" red -vGp $'\e[30;48;5;210m*\e[0m '
}
alias vim='nvim'
alias vi='nvim'
alias view='nvim -R'
alias vimdiff='nvim -d'
# building
alias valgrind='valgrind -q'
alias gnulib-tool='~/Documents/projects/foreign_projects.d/gnulib/gnulib-tool'
alias gitlog-to-changelog='gitlog-to-changelog --append-dot --strip-tab --commit-timezone'
alias configure="./configure -q"
alias automake="automake --gnits -W all" aclocal="aclocal -W all"
alias autom4te='autom4te -W all'
alias autoreconf='autoreconf -W all' make="make -j$(nproc) --shuffle=random"
alias mixvm='/usr/bin/mixvm -t -d -l' prof='gprof'
alias compile_static="echo 'sudo nix-shell -p glibc.static'"
alias shfmt='shfmt -w -s -p -ci -sr -fn' black='/usr/bin/black -q -l 80 --color'
alias autopep8='/usr/bin/autopep8 --in-place -j 0 -a --experimental'
alias apt='sudo nala' sudo='sudo '
# binary
alias nm='nm -P' hexdump='hexdump -L=auto' hd='/usr/bin/hd -L=auto'
# mathematics
alias goctave='octave --experimental-terminal-widget --gui --line-editing --traditional -q'
alias octave='octave --line-editing --traditional -q'
alias bc='bc -ilqs ~/.config/calc.bc'
alias gap='/usr/bin/gap -b'
# format
alias m4='m4 -EG'
alias man="man --warnings"
alias rich='python3 -m rich.markdown -c -p'
alias pdf='pdflatex --interaction=batchmode > /dev/null 2>&1'
alias gv='/usr/bin/gv -monochrome -fullscreen -watch'
alias gimp='gimp --no-cpu-accel -cs --stack-trace-mode never --pdb-compat-mode off &'
alias cwebp='cwebp -mt'
alias dmesg="dmesg ${C}"
alias clip='xclip -sel clip'
alias cal='gcal'
alias curl='curl --keepalive-time 3 --connect-timeout 10'
alias neofetch='fastfetch'

alias night='gammastep -O 4000'
alias day='gammastep -O 6500'
# xrandr --output eDP-1 --brightness 0.5
alias claudy='claude'
# >>> flclash-killswitch guard >>>
# Refuses to start Claude Code unless direct (non-VPN) connections are blocked.
# Added by ~/killswitch-setup.sh, removed by ~/killswitch-revert.sh.
# Unsafe bypass: command claude
claude() {
	if [ -x /usr/local/sbin/flclash-killswitch ]; then
		/usr/local/sbin/flclash-killswitch check >/dev/null 2>&1
		case $? in
		0) ;;
		1)
			printf '%s\n' 'claude: NOT started - direct internet connections are NOT blocked. See: flclash-killswitch status, ~/killswitch/README' >&2
			return 1
			;;
		*)
			printf '%s\n' 'claude: NOT started - the killswitch leak test could not confirm protection. See: flclash-killswitch check, ~/killswitch/README' >&2
			return 1
			;;
		esac
	fi
	command claude "$@"
}
# <<< flclash-killswitch guard <<<
