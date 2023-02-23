#!/usr/bin/env bash

declare -A dot_files
dot_files[alacritty.yml]="$HOME/.alacritty.yml"
dot_files[bashrc]="$HOME/.bashrc"
dot_files[settings.json]="$HOME/.config/Code/User/settings.json"
dot_files[vimrc]="$HOME/.vim/vimrc"

declare -A dot_folders
dot_folders[bash_files]="$HOME/.bash_files"

usage() {
	name="./${BASH_SOURCE}"
	echo -e "Process your configuration files"
	echo -e "USAGE"
	echo -e "- show this message (default)"
	echo -e "\t $name [-h, --help]"
	echo -e "- pack  your configuration files to project folder"
	echo -e "\t $name pack branch_name commit_message is_signed"
	echo -e "- install your configuration files to system"
	echo -e "\t $name install"
	echo "----------------------------------------------------------------"
	echo "mb6ockatf, Thu 23 Feb 2023 09:55:35 PM MSK"
}

mode=$1
if [ $mode == "pack" ]
then
	for filename in ${!dot_files[@]}
	do
		cp -v $"${dot_files[$filename]}" "$filename"
	done
	echo "${#dot_files[@]} dotfiles successfully packed"
	for foldername in ${!dot_folders[@]}
	do
		cp -vr $"${dot_folders[$foldername]}" "$foldername"
	done
	echo "${#dot_folders[@]} dotfolders successfully packed"
elif [ $mode == "install" ]
then
	for filename in ${!dot_files[@]}; do
		cp -v "$filename" "${dot_files[$filename]}"
	done
	echo "${#dot_files[@]} dotfiles successfully installed"
	for foldername in ${!dot_folders[@]}
	do
		cp -vr "$foldername" "${dot_files[$filename]}"
	done
	echo "${#dot_folders[@]} dotfolders successfully installed"
elif [ "$mode" == "-h" ] || [ $mode == "--help" ]
then
	usage
else
	echo "no mode value provided"
	usage
fi

