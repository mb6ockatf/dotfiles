vim9script
# Mon 06 Feb 2023 07:06:24 PM MSK : https://github.com/mb6ockatf/cute-vimrc
set nocompatible
set number
set nobomb
set wrap
set linebreak
set textwidth=80
set colorcolumn=80
set backspace=2
set autoindent
set laststatus=2
set history=50
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate
set cmdheight=3
set mouse-=a
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
filetype detect
if &filetype == "python"
    set tabstop=4
    set expandtab
    set shiftwidth=4
endif
colorscheme default
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'mb6ockatf/citify'
call plug#end()
# PlugUpdate
# PlugInstall
colorscheme gruvbox
set bg=dark
# var color_list = ["darkblue", "desert", "desert", "evening"]
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
	%s/\^datetime\^/\=strftime("%c")/e
	set fileencoding=utf-8
endfunction
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
autocmd vimenter * ++nested colo gruvbox
augroup END
syntax on

