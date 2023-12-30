# dotfiles

- [`onion/alacritty.yml`](alacritty.yml) for
[alacritty terminal emulator](https://github.com/alacritty/alacritty)
- [`onion/vimrc`](vimrc) for [Vim text editor](https://vimhelp.org/)
- [`onion/bashrc`](bashrc) for
[bash command interpreter](https://tiswww.case.edu/php/chet/bash/bashtop.html)
- [`onion/vscode_argv.json`](vscode_argv.json) for
[vscode](https://code.visualstudio.com/)
- [`onion/bspwmrc`](bspwmrc) for
[bspwm display manager](https://github.com/baskerville/bspwm)
- [`onion/sxhkdrc`](sxhkdrc) for
[sxhkd hotkey manager](https://github.com/baskerville/sxhkd)
- [`onion/neofetch.conf`](neofetch.conf) for
[neofetch](https://github.com/dylanaraps/neofetch)
- `onion/polybar/` for [polybar](https://github.com/polybar/polybar)

for rofi there is
[@adi1090x's configuration setup](https://github.com/adi1090x/rofi)

## setup.sh

there's a [`onion/setup.sh`](setup.sh), which has 2 modes:

- `pack` - to update project files with current system ones:

```sh
./setup.sh pack
```

to install[^1] all dotfiles into your system, run
to pack[^1] your dotfiles to this project:

```sh
./setup.sh install
```

- `install` - to update system configuration files with ones inside project
You can read more with `./setup.sh --help`

## tracking new files
you may want to add more dotfiles into [`setup.sh`](setup.sh).
1. add path of your new dotfile's folder into `dot_folders` array
2. add your dotfile into `dotfiles` associative array. *Key* is a path, where
   inside project your dotfile will be stored, and *value* is a path where in
   system your dotfile will be stored

for instance,
```sh
dot_folders[6]="$HOME/.vim"
dot_files[vimrc]="$HOME/.vim/vimrc"
```
will track system file `$HOME/.vim/vimrc` as `vimrc` in project

`./setup.sh install` will copy `vimrc` to `$HOME/.vim/vimrc`;
`./setup.sh pack` will do the vise versa.
checkout `./setup.sh help` for more information


## Other

checkout quick vim commands reference in
[wiki](https://github.com/mb6ockatf/dotfiles/wiki/short-vim-commands-reference)

[^1]: note that [`setup.sh`](setup.sh) will only update files if replacing
    older file or if old file does not exist.
