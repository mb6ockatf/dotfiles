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
	python3='python3 -q' bc='bc -ilqs ~/.config/calc.bc' \
	sed='sed --posix' awk='awk --posix' apl="apl -q --Color" \
	mkdir='mkdir -p' sort="sort --parallel=$CPU_NUMBER" \
	chown='chown --preserve-root' chmod='chmod --preserve-root' \
	chgrp='chgrp --preserve-root' rm='rm -iI --preserve-root' \
	basenc='basenc --preserve-root' \
	ls='ls -hGUF --color=always -w 80' dir='dir -hGU --color=always -w 80' \
	vdir='vdir -hGU --color=always -w 80' grep='grep --color=always' \
	fgrep='grep -F' egrep='grep -E' rgrep='grep -r' \
	pathchk='pathchk --portability' \
	gimp='gimp --no-cpu-accel -cs --stack-trace-mode never --pdb-compat-mode off &' \
	configure="./configure -q" automake="automake --gnits -W all" \
	aclocal="aclocal -W all" autom4te='autom4te -W all' \
	autoreconf='autoreconf -W all' \
	make="make -j ${CPU_NUMBER} -s --shuffle=${RANDOM}" \
	m4='m4 -EG' man="man --warnings" \
	compile_static="echo 'sudo nix-shell -p glibc.static'" \
	xz='xz -e' bzip2='bzip2 --best' \
	hexdump='hexdump -L=always' \
	hd='hd -L=always' ..='cd .. 2>&1 > /dev/null' \
	unzip='unzip -q' ss='ss -f' unrar='unrar-free' \
	cwebp='cwebp -mt' errno='errno -ls' shuf='shuf --random-source=/dev/urandom' \
	~='cd ~ 2>&1 > /dev/null' parallel="parallel -l 80 -j $CPU_NUMBER" \
	fmt='fmt -u' mkdtemp='mktemp -d' mkstemp='mktemp' who='who -HT' nl='nl -b a' \
	shfmt='shfmt -w -s -p -ci -sr -fn' \
	pdf='pdflatex --interaction=batchmode 2>&1 > /dev/null'

