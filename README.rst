===============================================================================
dotfiles
===============================================================================

* `alacrutty.yml <onion/alacritty.yml>`_ for
  `alacritty terminal emulator <http://githum.com/alacritty/alacritty>`_
* `vimrc <onion/vimrc>`_ for `Vim text editor <https://vimhelp.org/>`_
* `bashrc <onion/bashrc>`_ for `bash command interpreter
  <https://tiswww.case.edu/php/chet/bash/bashtop.html>`_
* `vscode_argv.json <onion/vscode_argv.json>`_ for
  `vscode <https://code.visualstudio.com/>`_
* `bspwmrc <onion/bspwmrc>`_ for
  `bspwm display manager <https://github.com/baskerville/bspwm>`_
* `sxhkdrc <onion/sxhkdrc>_` for
  `sxhkd hotkey manager <https://github.com/baskerville/sxhkd>`_
* `neofetch.conf <onion/neofetch.conf>`_ for
  `neofetch <https://github.com/dylanaraps/neofetch>`_
* `polybar/* <onion/polybar/>`_ for
  `polybar <https://github.com/polybar/polybar>`_

for rofi there is
`@adi1090x's configuration setup <https://github.com/adi1090x/rofi>`_

setup.sh
===============================================================================

there's a `setup.sh <onion/setup.sh>`_, which has 2 modes:

* ``pack`` - to update project files with current system ones:

::

        ./setup.sh pack


note that `setup.sh <onion/setup.sh>`_ will only update files if replacing
older file or if old file does not exist.

::

        ./setup.sh install

- ``install`` - to update system configuration files with ones inside project
You can read more with ``./setup.sh --help``

tracking new files
===============================================================================

you may want to add more dotfiles into `setup.sh <onion/setup.sh>`_.
1. add path of your new dotfile's folder into ``dot_folders`` array
2. add your dotfile into ``dotfiles`` associative array. *Key* is a path, where
   inside project your dotfile will be stored, and *value* is a path where in
   system your dotfile will be stored

for instance,

::

        dot_folders[6]="$HOME/.vim"
        dot_files[vimrc]="$HOME/.vim/vimrc"

will track system file ``$HOME/.vim/vimrc`` as ``vimrc`` in project

``./setup.sh install`` will copy ``vimrc`` to ``$HOME/.vim/vimrc``;
``./setup.sh pack`` will do the vise versa.
checkout ``./setup.sh help`` for more information

Other
===============================================================================

checkout quick vim commands reference in
`wiki <https://github.com/mb6ockatf/dotfiles/wiki/short-vim-commands-reference>`_

