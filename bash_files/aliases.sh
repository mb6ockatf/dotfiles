#!/usr/bin/env bash
# ~/.bash_files/aliases.sh
# Sat 08 Apr 2023 01:52:12 PM MSK
alias cp='cp -i'
alias df='df -h'
alias free='free -m'
alias np='nano -w PKGBUILD'
alias more=less
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias py='python3'
alias pip='python3 -m pip'
alias vi='vim'
alias google-chrome='/usr/bin/google-chrome-stable %U'
alias status='git status'
# Note that "commit" command is controlled in ~/.bash_files/functions.sh by gum
alias pull='git pull'
alias push='git push'
alias add='git add'
if [ -d "$HOME/.atom" ]
then
	alias atom="~/.atom/atom &"
else
	echo "atom directory does not exist"
fi
