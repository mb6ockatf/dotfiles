" Thu Apr 20 13:11:45 2023 | repository: https://github.com/mb6ockatf/dotfiles

call plug#begin()
Plug 'morhetz/gruvbox'
" Plug 'mb6ockatf/citify'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
" Plug 'vim-airline/vim-airline'
call plug#end()
" PlugUpdate
" PlugInstall
colorscheme gruvbox
set bg=dark
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
set conceallevel=1
let g:tex_conceal = 'abdmg'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

