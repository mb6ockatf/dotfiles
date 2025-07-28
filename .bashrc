#!/bin/bash
# .bashrc - Bourne-again shell rc dotfile.
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
[ -z "$PS1" ] && return
shopt -s histappend checkhash checkwinsize autocd cdable_vars cdspell \
	checkjobs cmdhist complete_fullquote dirspell expand_aliases \
	globskipdots gnu_errfmt histreedit histverify hostcomplete huponexit \
	interactive_comments lithist no_empty_cmd_completion nocaseglob \
	nocasematch progcomp progcomp_alias
set -o posix hashall history monitor noclobber notify nounset pipefail
declare -x LC_ALL=en_US.UTF-8 POSIXLY_CORRECT=true CLICOLOR=1 \
	PATH="/home/mb6ockatf/.local/bin:$PATH" HISTSIZE=10000000 \
	HISTFILESIZE=10000000 HISTCONTROL=ignoreboth:erasedups EDITOR=nvim \
	VISUAL=nvim GROFF_NO_SGR=1 GLOBSORT=nosort GAWK_READ_TIMEOUT=60000 \
	GAWK_SOCK_RETRIES=3 \
	CFLAGS='-std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror '`
	`'-Wfatal-errors -Wshadow -Wconversion -Wstrict-prototypes '`
	`'-Wold-style-definition' \
	PYTHON_COLORS=1 PYTHONOPTIMIZE=true \
	PYTHONSTARTUP="/home/${USER}/.config/pythonrc"
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.config/functions.sh ] && . ~/.config/functions.sh
[ -f /etc/.bash_completion ] && ! shopt -oq posix && . /etc/.bash_completion
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ] &&
	debian_chroot=$(cat /etc/debian_chroot)
sed -i -f ~/.config/clean_history.sed ~/.bash_history
sort -u ~/.bash_history -o ~/.bash_history

