# Tue 02 May 2023 08:36:18 PM MSK | https://github.com/mb6ockatf/dotfiles
# ~/.bashrc
[[ $- != *i* ]] && return
source "$HOME/.bash_files/functions.sh"
bash_completion_path="/usr/share/bash-completion/completion.sh"
use_color=true
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""
[[ -r $bash_completion_path ]] && source $bash_completion_path
[[ -f ~/.dir_colors ]]         && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]]       && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
if [[ -z ${match_lhs} ]]
then
	type -P dircolors >/dev/null
	match_lhs=$(dircolors --print-database)
fi
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true
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
unset use_color safe_term match_lhs sh bash_completion_path
shopt -s 'checkwinsize'
shopt -s 'expand_aliases'
shopt -s histappend
source ~/.bash_files/functions.sh
source ~/.bash_files/aliases.sh
source ~/.bash_files/colors.sh
source ~/.bash_files/prompt.sh
source ~/.bash_completion/alacritty
export QT_SELECT=4
export PYENV_ROOT="$HOME/.pyenv"
export HISTCONTROL=ignoreboth:erasedups
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
