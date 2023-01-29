vim9script
# Sat 28 Jan 2023 05:50:19 PM MSK
# repository: https://github.com/mb6ockatf/cute-vimrc
# makes sure that VIM is using your .vimrc file, not system defaults
set nocompatible  # disable vi compatibility
set nu  # display line number
set nobomb  # do not write Byte Order Mark
# do not affect the contents, but how the file is displayed:
set wrap  # wraps displayed text
set linebreak  # breaks the line in two when it's too long; requires wrap = True
set textwidth=80  # line cannot be longer than that
# set wrapmargin=0 not needed when textwidth is set. Vi-compatible
set colorcolumn=80  # draw a coloured line at this width
# set whichwrap+=<,>l,h
set backspace=2  # allows backspace to go to the previous line
set autoindent
set laststatus=2  # show last window's status line
# set statusline=%f%=%{&filetype}
var color_list = ["darkblue", "desert", "desert", "evening"]
set history=50  # store X lines of search & commands history
set ruler  # display cursor position
set showcmd  # show current entered command
set wildmenu  # show completion matches in a statusline
set ttimeout
set ttimeoutlen=100
set display=truncate
set cmdheight=3
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

map <F7> :tabp<CR>
map <F8> :tabn<CR>
map <F9> :tabnew<CR>
set mouse-=a
filetype detect
if &filetype == "python"
    se tabstop=4
    se expandtab
    se shiftwidth=4
endif
# colo stands for colorscheme
colorscheme default
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'mb6ockatf/citify'
call plug#end()
# PlugUpdate
# PlugInstall
colorscheme gruvbox
set bg=dark
# let color_choice = strftime(#%H") / 6
# if colors_name !~ g:color_list[g:color_choice]
#         execute "colorscheme " . g:color_list[g:color_choice]
# endif
if &filetype == "python"
	iabbrev im import
	iabbrev fr from
	iabbrev pr print(
	iabbrev inp input(
	iabbrev ret return
	iabbrev d def
	iabbrev cl class
	iabbrev init def init(
	iabbrev #"" """<CR>"""
	iabbrev ex except
	iabbrev t try:<CR>
	iabbrev w with
endif
function PrepareBeforeWrite()
	if &filetype == "python"
		%s/	/    /e
	endif
        %s/\s\+$//e
	%s/\^datetime\^/\=strftime(#%c")/e
	set fenc=utf-8  # set File encoding
endfunction
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
autocmd vimenter * ++nested colo gruvbox
augroup END
syntax on

