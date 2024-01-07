#!/usr/bin/env bash
declare -A dot_files
dot_files[tmux.conf]="$HOME/.tmux.conf"
dot_files[xinitrc]="$HOME/.xinitrc"
dot_files[alacritty.toml]="$HOME/.alacritty.toml"
dot_files[kitty.conf]="$HOME/.config/kitty/kitty.conf"
dot_files[gruvbox_dark.conf]="$HOME/.config/kitty/kitty-themes/themes/gruvbox_dark.conf"
dot_files[bashrc]="$HOME/.bashrc"
dot_files[gdbinit]="$HOME/.gdbinit"
dot_files[vscode_argv.json]="$HOME/.config/Code/User/settings.json"
dot_files[vimrc]="$HOME/.vim/vimrc"
dot_files[bspwmrc]="$HOME/.config/bspwm/bspwmrc"
dot_files[sxhkdrc]="$HOME/.config/sxhkd/sxhkdrc"
dot_files[neofetch.conf]="$HOME/.config/neofetch/config.conf"
dot_files[polybar/launch.sh]="$HOME/.config/polybar/launch.sh"
dot_files[polybar/config.ini]="$HOME/.config/polybar/config.ini"
declare -a dot_folders
dot_folders[1]="$HOME/.vim"
dot_folders[2]="$HOME/.config/Code/User"
dot_folders[3]="$HOME/.config/bspwm"
dot_folders[4]="$HOME/.config/sxhkd"
dot_folders[5]="$HOME/.config/neofetch"
dot_folders[6]="$HOME/.config/polybar"

repeat_char() {
	for ((i = 1; i < $2; i++)); do
		echo -n "$1"
	done
}

usage() {
	local name="${BASH_SOURCE[-1]}"
	cat << end_of_message
Process your configuration files

echo, cat, bash and pacman are required to run this script.
actually, all this setup is created for bash

USAGE
- show this message (default)
	$name [-h, --help]
- pack your configuration files to project folder
	$name pack
- install your configuration files to system
	$name install
- info
	story of this setup
- depends
	install build dependences
$(repeat_char - 80)
mb6ockatf, Sat 01 Jul 2023 01:19:20 PM MSK
last updated: Mon 14 Aug 2023 12:38:59 AM MSK
end_of_message
}

onion_info() {
	echo "$(<description.txt)"
}

collect_configuration() {
	for folder in "${dot_folders[@]}"; do
		mkdir -v -p "$folder"
	done
	for file in "${!dot_files[@]}"; do
		cp -vu $"${dot_files[$file]}" "$file"
	done
}

install_configuration() {
	for folder in "${!dot_folders[@]}"; do
		mkdir -v -p "${dot_folders[$folder]}"
	done
	for file in "${!dot_files[@]}"; do
		cp -vu "$file" "${dot_files[$file]}"
	done

	cd ~/.config/kitty
	ln -sf ./kitty-themes/themes/gruvbox_dark.conf ~/.config/kitty/theme.conf
}

set_package_manager() {
	local is_pacman=$(pacman --version)
	if [ -n "$(pacman --version)" ]; then
		package_manager_install="pacman -S"
	fi
}

install_deps() {
	if [[ -z "$package_manager_install" ]]; then
		set_package_manager
	fi
	sudo pacman -S --needed "$1"
}

pprint() {
	local message
	message=$(gum style --border normal --border-foreground 3 "$1")
	echo "$message"
}
echo "${BASH_SOURCE[*]}"
echoer="$(gum -v)"
if [ -z "${echoer}" ]; then
	echoer=echo
else
	echoer=pprint
fi
case $1 in
	pack | --pack | -p )
		collect_configuration ;;
	install | --install | -i )
		install_configuration ;;
	help | --help | -h )
		usage ;;
	info | -s )
		onion_info ;;
	depends | --depends | -d )
		$echoer "running system upgrade" && sudo pacman -Syuu
		if [[ $echoer == $echo ]]; then
			$echoer "installing gum" && pacman_install gum
		fi
		$echoer "installing pyenv" && pacman_install pyenv
		;;
	*)
		$echoer "no mode value provided" && usage ;;
esac
exit
