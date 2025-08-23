#!/usr/bin/env bash
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
set -o posix
if [ -x /usr/bin/dircolors ]
then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" ||
		eval "$(dircolors -b)"
fi

alias emacs='emacs -nw' \
	_='sudo' _i='sudo -i' fucking='sudo' please='sudo' \
	python3='python3 -q' bc='bc -ilqs ~/.config/calc.bc' sed='sed --posix' \
	awk='awk -P' apl="apl -q --Color" \
	chown='chown --preserve-root' chmod='chmod --preserve-root' \
	chgrp='chgrp --preserve-root' rm='rm -iI --preserve-root' \
	ls='ls --color=always' dir='dir --color=always' \
	vdir='vdir --color=always' grep='grep --color=always' \
	mkdir='mkdir -p' \
	fgrep='grep -F' egrep='grep -E' rgrep='grep -r' \
	md5sum='md5sum --quiet --strict' \
	gimp='gimp --no-cpu-accel -cs --stack-trace-mode never --pdb-compat-mode off &' \
	configure="./configure -q" automake="automake --gnits" \
	make="make -j 6 -s --shuffle=${RANDOM}" \
	m4='m4 -EG' man="man --warnings"

