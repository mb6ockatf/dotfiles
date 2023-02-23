# cute-configs

Set of simple configuration files. Currently, there are:
- `alacritty.yml` for [Alacritty terminal emulator](https://github.com/alacritty/alacritty)
- `vimrc` for [Vim text editor](https://vimhelp.org/)
- `bashrc` for [Bash command interpreter](https://tiswww.case.edu/php/chet/bash/bashtop.html)
- files sourced in `bashrc`:
    - `colors.sh`
    - `bash_aliases`
    - `bash_functions`
- `settings.json` for [vscode](https://code.visualstudio.com/)

# deploy
There's a `DEPLOY.sh` file, which has 2 launch modes:
- `pack` - to update project files with current system ones
- `install` - to update system configuration files with ones inside project

# usage howto
if you're not me, fork this repository first and do the following with it.
1. clone the repository and get into it
```sh
git clone git@github.com:mb6ockatf/cute-configs.git
cd HOME/cute-configs
```
2. to install all the configs into your system, run
```sh
source DEPLOY.sh install
```

If you've made a change in one of installed files, you can pack it into project
catalogue with
```sh
source DEPLOY.sh pack
```

------

Vim editing commands (just not to forget):
- a
- i
- o
- s
- r
- c
- w
- e
- r
- y
- hjkl
- x
- J
- H
- M
- L
- ^
- $
- n|
- ()
- {}
- [[]]
- /
- n
- f
- t
- ;
- ,
- G
- m

*by mb6ockatf, Thu 23 Feb 2023 08:41:22 PM MSK*

