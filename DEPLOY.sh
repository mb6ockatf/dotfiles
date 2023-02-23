#!/usr/bin/env bash

declare -A dot_files
dot_files[alacritty.yml]="$HOME/.alacritty.yml"
dot_files[bashrc]="$HOME/.bashrc"
dot_files[colors.sh]="$HOME/.colors.sh"
dot_files[settings.json]="$HOME/.config/Code/User/settings.json"
dot_files[vimrc]="$HOME/.vim/vimrc"
dot_files[bash_aliases]="$HOME/.bash_aliases"
dot_files[bash_functions]="$HOME/.bash_functions"
if [ "$1" == "pack" ]
then
	for filename in ${!dot_files[@]}; do
		cp --verbose $"${dot_files[$filename]}" "$filename"
	done
	echo "successfully packed to" `pwd`
elif [ "$1" == "install" ]
then
	for filename in ${!dot_files[@]}; do
		cp --verbose "$filename" "${dot_files[$filename]}"
	done
	echo "successfully installed in $HOME"
fi
return
