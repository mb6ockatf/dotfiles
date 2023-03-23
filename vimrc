vim9script
# Sun 26 Feb 2023 02:08:01 PM MSK
# repository: https://github.com/mb6ockatf/cute-configs
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
inoremap <S-Left> <Nop>
map <F7> :tabp<CR>
map <F8> :tabn<CR>
map <F9> :tabnew<CR>
set mouse-=a
filetype detect
if &filetype == "python" || &filetype == "sh" || &filetype == "vim"
	set tabstop=4
	set expandtab
	set shiftwidth=4
endif
if &filetype == "html" || &filetype == "css"
	set tabstop=2
	set shiftwidth=2
	set nolinebreak
	set colorcolumn=140
	set textwidth=140
	set wrap
endif
colorscheme default
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'mb6ockatf/citify'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
call plug#end()
# PlugUpdate
# PlugInstall
colorscheme gruvbox
set bg=dark
g:tex_flavor = 'latex'
g:vimtex_view_method = 'zathura'
g:vimtex_quickfix_mode = 0
set conceallevel=1
g:tex_conceal = 'abdmg'
g:UltiSnipsExpandTrigger = '<tab>'
g:UltiSnipsJumpForwardTrigger = '<tab>'
g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
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

