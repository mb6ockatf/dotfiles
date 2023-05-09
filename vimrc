set nocompatible
set number
set nobomb
set wrap
set wrapmargin=80
set linebreak
set textwidth=80
set colorcolumn=80
set backspace=2
set autoindent
set history=50
set ruler
set nopaste
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate
set cmdheight=1
set mouse-=a
set conceallevel=1
set bg=dark
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
map <F1> :w<CR>
map <F2> :wq<CR>
map <F3> :NERDTree<CR>
map <F7> :tabp<CR>
map <F8> :tabn<CR>
map <F9> :tabnew<CR>
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
filetype detect
if &filetype == "python" || &filetype == "vim" || &filetype == "sh"
	set tabstop=4
	set expandtab
	set shiftwidth=4
elseif &filetype == "html" || &filetype == "css"
	set tabstop=2
	set shiftwidth=2
	set nolinebreak
	set colorcolumn=140
	set textwidth=140
	set wrap
endif

function PrepareBeforeWrite()
	if &filetype == "python"
		%s/^	/    /e
	endif
	%s/\s\+$//e
	%s/\^datetime\^/\=strftime("%c")/e
	set fenc=utf-8
endfunction


" return '[\s]' if trailing whitespace is detected, return '' otherwise
function StatuslineTrailingSpaceWarning()
	if !exists("b:statusline_trailing_space_warning")
		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif
		if search('\s\+$', 'nw') != 0
			let b:statusline_trailing_space_warning = '[\s]'
		else
			let b:statusline_trailing_space_warning = ''
		endif
	endif
	return b:statusline_trailing_space_warning
endfunction

" return syntax highlight group under cursor, or ''
function StatuslineCurrentHighlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

" return '[&et]' if &et is set wrong highlight group under cursor ''
function StatuslineCurrentHightlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

" return '[mixed-indenting]' if spaces and tabs are used to indent, otherwise
" return empty string
function StatuslineTabWarning()
	if !exists("b:statusline_tab_warning")
		let b:statusline_tab_warning = ""
		if !&modifiable
			return b:statusline_tab_warning
		endif
		let tabs = search('^\t', 'nw') != 0
"       find spaces that aren't used as alignment in first indent column
		let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
		if tabs && spaces
			b:statusline_tab_warning = '[mixed-indenting]'
		elseif (spaces && !&et) || (tabs && &et)
			b:statusline_tab_warning = '[%et]'
		endif
	endif
	return b:statusline_tab_warning
endfunction

" return a warning for "long lines" where "long" is either textwidth value if it
" was set, otherwise 80
" return '' if no long lines
" return '[#x,my,$z]' if long lines are found, were x is number of long
" lines, y is median length of long lines and z is length of longest line
function StatuslineLongLineWarning()
	if !exists("b:statusline_long_line_warning")
		if !&modifiable
			let b:statusline_long_line_warning = ''
			return b:statusline_long_line_warning
		endif
		let long_line_lens = s:LongLines()
		if len(long_line_lens) > 0
			let b:statusline_long_line_warning = "[" .
					\ '#' . len(long_line_lens) . "," .
					\ 'm' . s:Median(long_line_lens) . "," .
					\ '$' . max(long_line_lens) . "]"
		else
			let b:statusline_long_line_warning = ""
		endif
	endif
	return b:statusline_long_line_warning
endfunction

" return list containing lengths of long lines in this buffer
function s:LongLines()
	let threshold = (&tw ? &tw : 80)
	let spaces = repeat(" ", &ts)
	let long_line_lens = []
	let i = 1
	while i <= line("$")
		let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
		if len > threshold
			call add(long_line_lens, len)
		endif
		let i += 1
	endwhile
	return long_line_lens
endfunction

function s:Median(nums)             " find the median of given array of numbers
	let nums = sort(a:nums)
	let l = len(nums)
	if l % 2 == 1
		let i = (l - 1) / 2
		return nums[i]
	else
		return nums[l / 2] + nums[(l / 2) - 1] / 2
	endif
endfunction


set laststatus=2
set statusline=%-03.f
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
set statusline+=%h%y%r%m
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%#warningmsg#
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*
set statusline+=%=
set statusline+=%{StatuslineCurrentHighlight()}\ \
set statusline+=%c,
set statusline+=%l/%L
set statusline+=\ %P
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning


augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
augroup END
syntax on
