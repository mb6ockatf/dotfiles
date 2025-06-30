#!/bin/bash

if [ -x /usr/bin/dircolors]
then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
		eval "$(dircolors -b)"
	alias ls='ls --color=auto' dir='dir--color=auto' \
		vdir='vdir --color=auto' grep='grep --color=auto' \
		fgrep='fgrep --color=auto' egrep='color --auto'
fi

alias ll='ls -lh' la='ls -lha' l='ls -CF' \
	emacs='emacs -nw' \
	_='sudo' _i='sudo -i' fucking='sudo' please='sudo' \
	python3='python3 -q' \
	gcc='gcc -Wall -Wextra -Wpedantic -pedantic-errors -Werror -Wfatal-errors' \
	chown='chown --preserve-root' chmod='chmod --preserve-root' \
	chgrp='chgrp --preserve-root' \
	rm='rm -ivI --preserve-root'

