#
# ~/.bashrc
#
[[ $- != *i* ]] && return
source "$HOME/.bash_files/functions.sh"
bash_completion_path="/usr/share/bash-completion/completion.sh"
if [ -r $bash_completion_path ]
then
	source $bash_completion_path
fi
use_color=true
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""
if [[ -f ~/.dir_colors ]]
then
	match_lhs="${match_lhs}$(<~/.dir_colors)"
fi
if [[ -f /etc/DIR_COLORS ]]
then
	match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
fi
if [[ -z ${match_lhs} ]]
then
	type -P dircolors >/dev/null
	match_lhs=$(dircolors --print-database)
fi
if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]]
then
	use_color=true
fi
if ${use_color}
then
	if type -P dircolors >/dev/null
	then
		if [[ -f ~/.dir_colors ]]
		then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]]
		then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi
fi
unset use_color safe_term match_lhs sh
shopt -s 'checkwinsize'
shopt -s 'expand_aliases'
export QT_SELECT=4
shopt -s histappend
source ~/.bash_files/aliases.sh
source ~/.bash_files/colors.sh
source ~/.bash_completion/alacritty

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

