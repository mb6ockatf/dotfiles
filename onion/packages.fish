#!/usr/bin/env fish
## https://github.com/Jguer/yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -frd yay-bin
yay -Syuu linux-lts linux util-linux bash
yay -Syuu vim sxhkd bspwm rofi polybar gcc
yay -Syuu python3 google-chrome kitty less
yay -Qyuu libreoffice-still pandoc csvkit
yay -Qyuu python3 python-pip
yay -Syuu fortune-mod cowsay github-cli bc
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
