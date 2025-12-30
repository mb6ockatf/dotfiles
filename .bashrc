#!/usr/bin/env bash

# [ -z "$PS1" ] && return
case $- in
	*i*) ;;
	*) return ;;
esac
shopt -s histappend checkhash checkwinsize autocd cdable_vars cdspell \
	checkjobs cmdhist complete_fullquote dirspell expand_aliases \
	globskipdots gnu_errfmt histreedit histverify hostcomplete huponexit \
	interactive_comments lithist no_empty_cmd_completion nocaseglob \
	nocasematch progcomp progcomp_alias globstar
set -o posix hashall history monitor noclobber notify nounset pipefail
declare -x LC_ALL=en_US.UTF-8 POSIXLY_CORRECT=true CLICOLOR=1 \
	PATH="/usr/local/bin:/usr/local/sbin:$PATH" \
	PATH="/usr/sbin:/home/$USER/.local/bin:$PATH" \
	MANPATH="/home/$USER/.local/share/man:$MANPATH" \
	NIX_BUILD_CORES=0 \
	HISTSIZE=100000000 HISTFILESIZE=100000000 \
	HISTIGNORE="cd:rm:rmdir:mkdir:man:nvim:vim:less:clear:exit:[bf]g:git clone git@:cat:tac:rev:" \
	HISTCONTROL="$HISTCONTROL:ignoreboth:erasedups" GROFF_NO_SGR=1 \
	PS1="$ " \
	GLOBSORT=nosort GAWK_READ_TIMEOUT=60000 GAWK_SOCK_RETRIES=3 \
	CFLAGS='-std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror -Wfatal-errors' \
	PYTHON_COLORS=1 PYTHONOPTIMIZE=true \
	PYTHONSTARTUP="/home/$USER/.config/pythonrc" \
	LESS='-Q --use-color --wordwrap --wheel-lines=0' \
	CPU_NUMBER="$(nproc --all)" VMOPTIONS="$HOME/.jetbrains.vmoptions.sh" \
	LESSSECURE=1 PAGER='less' MANPAGER='less' PROCPS_USERLEN=10 EPERM=1 \
	ENOENT=2 ESRCH=3 EINTR=4 EIO=5 ENXIO=6 E2BIG=7 ENOEXEC=8 EBADF=9 \
	ECHILD=10 EAGAIN=11 ENOMEM=12 EACCES=13 EFAULT=14 ENOTBLK=15 EBUSY=16 \
	EEXIST=17 EXDEV=18 ENODEV=19 ENOTDIR=20 EISDIR=21 EINVAL=22 ENFILE=23 \
	EMFILE=24 ENOTTY=25 ETXTBSY=26 EFBIG=27 ENOSPC=28 ESPIPE=29 EROFS=30 \
	EMLINK=31 EPIPE=32 EDOM=33 ERANGE=34 EDEADLK=35 ENAMETOOLONG=36 \
	ENOLCK=37 ENOSYS=38 ENOTEMPTY=39 ELOOP=40 ENOMSG=42 EIDRM=43 \
	ECHRNG=44 EL2NSYNC=45 EL3HLT=46 EL3RST=47 ELNRNG=48 EUNATCH=49 \
	ENOCSI=50 EL2HLT=51 EBADE=52 EBADR=53 EXFULL=54 ENOANO=55 EBADRQC=56 \
	EBADSLT=57 EBFONT=59 ENOSTR=60 ENODATA=61 ETIME=62 ENOSR=63 ENONET=64 \
	ENOPKG=65 EREMOTE=66 ENOLINK=67 EADV=68 ESRMNT=69 ECOMM=70 EPROTO=71 \
	EMULTIHOP=72 EDOTDOT=73 EBADMSG=74 EOVERFLOW=75 ENOTUNIQ=76 EBADFD=77 \
	EREMCHG=78 ELIBACC=79 ELIBBAD=80 ELIBSCN=81 ELIBMAX=82 ELIBEXEC=83 \
	EILSEQ=84 ERESTART=85 ESTRPIPE=86 EUSERS=87 ENOTSOCK=88 \
	EDESTADDRREQ=89 EMSGSIZE=90 EPROTOTYPE=91 ENOPROTOOPT=92 \
	EPROTONOSUPPORT=93 ESOCKTNOSUPPORT=94 EOPNOTSUP=95 EPFNOSUPPORT=96 \
	EAFNOSUPPORT=97 EADDRINUSE=98 EADDRNOTAVAIL=99 ENETDOWN=100 \
	ENETUNREACH=101 ENETRESET=102 ECONNABORTED=103 ECONNRESET=104 \
	ENOBUFS=105 EISCONN=106 ENOTCONN=107 ESHUTCONN=108 ETOOMANYREFS=109 \
	ETIMEDOUT=110 ECONNREFUSED=111 EHOSTDOWN=112 EHOSTUNREACH=113 \
	EALREADY=114 EINPROGRESS=115 ESTALE=116 EUCLEAN=117 ENOTNAM=118 \
	ENAVAIL=119 EISNAM=120 EREMOTEIO=121 EDQUOT=122 ENOMEDIUM=123 \
	EMEDIUMTYPE=124 ECANCELED=125 ENOKEY=126 EKEYEXPIRED=127 \
	EKEYREVOKED=128 EKEYREJECTED=129 EOWNERDEAD=130 ENOTRECOVERABLE=131 \
	ERFKILL=132 EHWPOISON=133 ENOTSUP=134 ENOMEDIUM=135 EILSEQ=138 \
	EOVERFLOW=139 ECANCELED=140 ENOTRECOVERABLE=141 EOWNERDEAD=142 \
	ESTRPIPE=143
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.config/functions.sh ] && . ~/.config/functions.sh
if $IS_NVIM_HERE; then
	declare -x EDITOR=nvim VISUAL=nvim
else
	declare -x EDITOR=vim VISUAL=vim
fi
[ -f /etc/.bash_completion ] && ! shopt -oq posix && . /etc/.bash_completion
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ] &&
	debian_chroot=$(cat /etc/debian_chroot)
[ -f "$VMOPTIONS" ] && . "$___MY_VMOPTIONS_SHELL_FILE"
sed -i -f ~/.config/clean_history.sed ~/.bash_history
sort -u ~/.bash_history -o ~/.bash_history
clear

