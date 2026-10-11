ENV=$HOME/.shinit
export ENV
export LC_ALL=en_US.UTF-8 POSIXLY_CORRECT=true PATH="/usr/local/bin:/usr/local/sbin:/usr/sbin:/home/${USER}/.local/bin:/home/mb6ockatf/.juliaup/bin:/opt/idea-IU-261.24374.151/plugins/Kotlin/kotlinc/bin/:/opt/idea-IU-261.24374.151/jbr/bin/:${PATH}" NIX_BUILD_CORES=0 CFLAGS="-std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror -Wfatal-errors -lm -g3 -D_FORTIFY_SOURCE=3" COB_CFLAGS="-O0 -g -std=ibm-strict -fstatic-call -ffold-copy=lower -fdebugging -ftrace -fstack-check " CPU_NUMBER="$(nproc --all)" VMOPTIONS="$HOME/.jetbrains.vmoptions.sh" PROCPS_USERLEN=10 HISTSIZE=100000000 HISTFILESIZE=100000000 HISTIGNORE='cd:ls:rm:cp:mv:rmdir:mkdir:man:nvim:vim:less:lesss:lesst:clear:exit:[bf]g:git clone git@:cat:tac:rev:make:apt:apt-fast:apt-get:echo:factor:indent:clip:chmod:touch' HISTCONTROL="${HISTCONTROL}:ignoreboth:erasedups" MANPATH="/home/$USER/.local/share/man:$MANPATH" MANWIDTH=$(tput cols) LESS='-Q --use-color --wordwrap --wheel-lines=0 --no-keypad --no-histdups' LESSSECURE=1 PAGER='less' MANPAGER='less' PYTHON_COLORS=1 PYTHONOPTIMIZE=true PYTHONSTARTUP="/home/$USER/.config/pythonrc" GLOBSORT=nosort GAWK_READ_TIMEOUT=60000 GAWK_SOCK_RETRIES=3 CLICOLOR=1 GROFF_NO_SGR=1 PS1='$ ' documents=~/Documents/ projects="${documents}/projects" notes="${projects}/notes" algs="${notes}/algs" solutions="${projects}/solutions" cf="${solutions}/codeforces" GCAL='--exit-status-help-non-zero --time-offset=+03:00 --atmosphere=991.915643,20 --precise --gregorian-reform=1918,02,01,13 --iso-week-number=yes -s 2 -X -G -K'
[ -r ~/.profile.local ] && . ~/.profile.local
sort -u ~/.bash_history -o ~/.bash_history
sed -i -f ~/.config/clean_history.sed ~/.bash_history
[[ -z "$debian_chroot" && -r /etc/debian_chroot ]] && export debian_chroot=$(cat /etc/debian_chroot)
[[ -f ~/.bashrc ]] && source ~/.bashrc
# >>> juliaup initialize >>>
# !! Contents within this block are managed by juliaup !!
case ":$PATH:" in
    *:/home/mb6ockatf/.juliaup/bin:*) ;;
    *) export PATH=/home/mb6ockatf/.juliaup/bin${PATH:+:${PATH}} ;;
esac
# <<< juliaup initialize <<<
export GTK_IM_MODULE=ibus QT_IM_MODULE=ibus XMODIFIERS=@im=ibus
ibus-daemon -drx
