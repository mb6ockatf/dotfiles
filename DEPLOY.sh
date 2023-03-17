#!/usr/bin/env bash

declare -A dot_files
dot_files[alacritty.yml]="$HOME/.alacritty.yml"
dot_files[bashrc]="$HOME/.bashrc"
dot_files[config/Code/User/settings.json]="$HOME/.config/Code/User/settings.json"
dot_files[vimrc]="$HOME/.vim/vimrc"
dot_files[bash_files/aliases.sh]="$HOME/.bash_files/aliases.sh"
dot_files[bash_files/colors.sh]="$HOME/.bash_files/colors.sh"
dot_files[bash_files/functions.sh]="$HOME/.bash_files/functions.sh"
dot_files[config/bspwm/bspwmrc]="$HOME/.config/bspwm/bspwmrc"
dot_files[config/sxhkd/sxhkdrc]="$HOME/.config/sxhkd/sxhkdrc"
dot_files[config/neofetch/config.conf]="$HOME/.config/neofetch/config.conf"

declare -a dot_folders
dot_folders[0]="$HOME/.bash_files"
dot_folders[1]="$HOME/.vim"
dot_folders[2]="$HOME/.config/Code/User"
dot_folders[3]="$HOME/.config/bspwm"
dot_folders[4]="$HOME/.config/sxhkd"
dot_folders[5]="$HOME/.config/neofetch"

line="----------------------------------------------------------------"

usage() {
	name="${BASH_SOURCE}"
	echo -e "Process your configuration files"
	echo -e "USAGE"
	echo -e "- show this message (default)"
	echo -e "\t $name [-h, --help]"
	echo -e "- pack  your configuration files to project folder"
	echo -e "\t $name pack branch_name commit_message is_signed"
	echo -e "- install your configuration files to system"
	echo -e "\t $name install"
	echo $line
	echo "mb6ockatf, Thu 23 Feb 2023 09:55:35 PM MSK"
	unset name
}

case $1 in
	pack | --pack | -p )
		for foldername in ${dot_folders[@]}
		do
			mkdir -v -p "$foldername"
		done
		for filename in ${!dot_files[@]}
		do
			cp -vu $"${dot_files[$filename]}" "$filename"
		done
		;;
	install | --install | -i )
		for foldername in ${!dot_folders[@]}
		do
			mkdir -v -p "${dot_folders[$foldername]}"
		done
		for filename in ${!dot_files[@]}
		do
			cp -vu "$filename" "${dot_files[$filename]}"
		done
		;;
	help | --help | -h)
		usage
		;;
	*)
		echo "no mode value provided"
		usage
	;;
esac
echo
unset filename
unset foldername
unset usage
unset dot_files
unset dot_folders
exit

