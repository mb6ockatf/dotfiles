#!/bin/bash
[ -z "$PS1" ] && return
shopt -s histappend checkhash checkwinsize;
set -o posix;
export POSIXLY_CORRECT=true CLICOLOR=1 \
	PATH="/home/mb6ockatf/.local/bin:$PATH" \
	HISTSIZE=100000 HISTFILESIZE=200000 \
	HISTCONTROL=ignoreboth:erasedups EDITOR=nvim GROFF_NO_SGR=1
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.config/functions.sh ] && . ~/.config/functions.sh
[ -f /etc/.bash_completion ] && ! shopt -oq posix && . /etc/.bash_completion
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ] && \
	debian_chroot=$(cat /etc/debian_chroot)
