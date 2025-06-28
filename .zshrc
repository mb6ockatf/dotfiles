# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mb6ockatf/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
alias -g ls='ls -Fh --color=auto' grep='grep --color=auto' egrep='grep -E' \
	ln='ln -i' cp='cp -i' df='df -h' chown='chown --preserve-root' \
	chmod='chmod --preserve-root' chgrp='chgrp --preserve-root' \
	rm='rm -ivI --preserve-root'
