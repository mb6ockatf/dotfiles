#!/usr/bin/env fish
## https://github.com/Jguer/yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -frd yay-bin

yay -Syuu vim sxhkd bspwm rofi polybar util-linux
yay -Syuu python3 fish google-chrome kitty less
yay -Syuu fortune-mod cowsay github-cli libreoffice-still
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
