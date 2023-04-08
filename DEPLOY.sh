#!/usr/bin/env bash

declare -A dot_files
dot_files[alacritty/alacritty.yml]="$HOME/.alacritty.yml"
dot_files[alacritty/bash_completion.sh]="$HOME/.bash_completion/alacritty"
dot_files[bashrc]="$HOME/.bashrc"
dot_files[Code/User/settings.json]="$HOME/.config/Code/User/settings.json"
dot_files[vimrc]="$HOME/.vim/vimrc"
dot_files[bash_files/aliases.sh]="$HOME/.bash_files/aliases.sh"
dot_files[bash_files/colors.sh]="$HOME/.bash_files/colors.sh"
dot_files[bash_files/functions.sh]="$HOME/.bash_files/functions.sh"
dot_files[bash_files/prompt.sh]="$HOME/.bash_files/prompt.sh"
dot_files[bspwm/bspwmrc]="$HOME/.config/bspwm/bspwmrc"
dot_files[sxhkd/sxhkdrc]="$HOME/.config/sxhkd/sxhkdrc"
dot_files[neofetch/config.conf]="$HOME/.config/neofetch/config.conf"
dot_files[polybar/launch.sh]="$HOME/.config/polybar/launch.sh"
dot_files[polybar/config.ini]="$HOME/.config/polybar/config.ini"

declare -a dot_folders
dot_folders[0]="$HOME/.bash_files"
dot_folders[1]="$HOME/.vim"
dot_folders[2]="$HOME/.config/Code/User"
dot_folders[3]="$HOME/.config/bspwm"
dot_folders[4]="$HOME/.config/sxhkd"
dot_folders[5]="$HOME/.config/neofetch"
dot_folders[6]="$HOME/.config/polybar"
dot_folders[7]="$HOME/.bash_completion"

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
	echo "mb6ockatf, Sun 19 Mar 2023 04:17:10 PM MSK"
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

