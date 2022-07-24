# cute-vimrc

## Up-to-time description of commands used in .vimrc
1. [nocopatible](https://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless)
- in a nutshell, makes sure that VIM is using your .vimrc file, not system defaults

2. `nu` - enable line numbers

3. `nobomb` - avoid problems with pasting CTRL+SHIFT+V into VIM. See `:help nobomb` for more
details

4. `wrap`, `linebreak`, `textwidth`, `wrapmargin`, `colorcolumn` are things to make text wrap at
100th column

5. `whichwrap` - allow moving to the next / previous line whith `h`, `l` and arrows then end /
beginning of line is reached

6. `backspace 2` allows backspace to go to the previous line if there is no characters left on the
current one

7. `color_list` - list of colorschemes. One of them will be set depending when VIM is launched

8. On lines 17 - 31 some abbreviations for Python files are set. `ia` is a shortened `iabbrev`

9. Function `PrepareBeforeWrite` is launched before writing file (i.e. before `:w` command is
executed). It deletes trailing whitespaces, substitute `\^datatime\^` string
with current date and time (i.e. time of writing), sets file encoding to utf-8. The last one is
important for files which are going to be opened on both Windows NT and Linux / Unix systems

10. At the end of file, `PrepareBeforeWrite is binded to BufWritePre event. Syntax highligh is
turned on.


*by mb6ockatf, 7/24/2022 2:11:56 PM*

