# cute-configs

Set of simple dotfiles. Currently, there are:
- `alacritty.yml` for [Alacritty terminal emulator](https://github.com/alacritty/alacritty)
- `vimrc` for [Vim text editor](https://vimhelp.org/)
- `bashrc` for [Bash command interpreter](https://tiswww.case.edu/php/chet/bash/bashtop.html)
- files sourced in `bashrc`:
    - `colors.sh`
    - `bash_aliases`
    - `bash_functions`
- `settings.json` for [vscode](https://code.visualstudio.com/)

## DEPLOY.sh
There's a `DEPLOY.sh` file, which has 2 launch modes:
- `pack` - to update project files with current system ones
- `install` - to update system configuration files with ones inside project
You can read more with "./DEPLOY.sh --help"

## Usage HOWTO
1. Fork, if needed, and clone the repository
```sh
git clone git@github.com:mb6ockatf/cute-configs.git
cd HOME/cute-configs
```
2. To install[^1] all dotfiles into your system, run
```sh
./DEPLOY.sh install
```

To pack[^1] your dotfiles to this project, run
```sh
./DEPLOY.sh pack
```

Then, push them to your repository with
```sh
git add <files>
git commit
git push
```

## Tracking new files
You may want to add more dotfiles into `DEPLOY.sh`.
1. Add path of your new dotfile's folder into `dot_folders` array
2. Add your dotfile into `dotfiles` associative array. *Key* is a path, where
   inside project your dotfile will be stored, and *value* is a path where in
   system your dotfile will be stored.

For instance,
```sh
dot_folders[6]="$HOME/.vim"
dot_files[vimrc]="$HOME/.vim/vimrc"
```
will track system file `$HOME/.vim/vimrc` as just `vimrc` in project.
`./DEPLOY.sh install` will copy `cte-vimrc` to `$HOME/.vim/vimrc`;
`./DEPLOY.sh pack` will do the vise versa.

------

[^1]: Note that `DEPLOY.sh` will only update files if replacing older file or if
    old file does not exist.
