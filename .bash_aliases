#!/bin/bash
# .bash_aliases - an addition to .bashrc, with bash aliases
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

if [ -x /usr/bin/dircolors ]
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
	chown='chown --preserve-root' chmod='chmod --preserve-root' \
	chgrp='chgrp --preserve-root' \
	rm='rm -iI --preserve-root' \
	gcc='gcc -std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror '`
	`'-Wfatal-errors -Wshadow -Wconversion -Wstrict-prototypes '`
	`'-Wold-style-definition'

