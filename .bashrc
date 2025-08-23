#!/usr/bin/env bash --posix
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
	PATH="/usr/local/bin:/usr/local/sbin:${PATH}" \
	PATH="/usr/sbin:/home/${USER}/.local/bin:${PATH}" \
	MANPATH="/home/${USER}/.local/share/man:${MANPATH}"
	PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "
declare -x HISTSIZE=10000000 HISTFILESIZE=10000000 \
	HISTIGNORE='clear:cd:exit:[bf]g' \
	HISTCONTROL="${HISTCONTROL}:ignoreboth:erasedups"
declare -x
declare -x GROFF_NO_SGR=1 GLOBSORT=nosort GAWK_READ_TIMEOUT=60000 \
	GAWK_SOCK_RETRIES=3 \
	CFLAGS='-std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror '`
	`'-Wfatal-errors'
declare -x PYTHON_COLORS=1 PYTHONOPTIMIZE=true \
	PYTHONSTARTUP="/home/${USER}/.config/pythonrc"
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.config/functions.sh ] && . ~/.config/functions.sh
if $IS_NVIM_HERE
then
	declare -x EDITOR=nvim VISUAL=nvim
else
	declare -x EDITOR=vim VISUAL=vim
fi
[ -f /etc/.bash_completion ] && ! shopt -oq posix && . /etc/.bash_completion
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ] &&
	debian_chroot=$(cat /etc/debian_chroot)
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"
if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]
then
	. "${___MY_VMOPTIONS_SHELL_FILE}"
fi
sed -i -f ~/.config/clean_history.sed ~/.bash_history
sort -u ~/.bash_history -o ~/.bash_history

