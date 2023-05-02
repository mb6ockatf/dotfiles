call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
call plug#end()
" PlugUpdate
" PlugInstall
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:tex_conceal = 'abdmg'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
