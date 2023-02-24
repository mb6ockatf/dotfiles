vim9script
# Sat 25 Feb 2023 12:20:16 AM MSK
# repository: https://github.com/mb6ockatf/cute - vimrc
set nocompatible
set nu
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
colorscheme default
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'mb6ockatf/citify'
call plug#end()
# PlugUpdate
# PlugInstall
colorscheme gruvbox
set bg=dark
function PrepareBeforeWrite()
	if &filetype == "python"
		%s/^	/    /e
	endif
 	%s/\s\+$//e
 	%s/\^datetime\^/\=strftime("%c")/e
	set fenc=utf-8
endfunction
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
autocmd vimenter * ++nested colo gruvbox
augroup END
syntax on

