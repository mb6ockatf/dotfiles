" Tue 28 Mar 2023 05:52:28 PM MSK
" repository: https://github.com/mb6ockatf/dotfiles
set nocompatible
set nu
set nobomb
set wrap
set linebreak
set textwidth=80
set colorcolumn=80
set backspace=2
set autoindent
set history=50
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate

" return '[\s]' if trailing whitespace is detected; return '' otherwise
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

" return the syntax highlight group under the cursor ''
function StatuslineCurrentHighlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

" return '[&et]' if &et is set wrong highlight group under the cursor ''
function StatuslineCurrentHightlight()
	let name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function StatuslineTabWarning()
	if !exists("b:statusline_tab_warning")
		let b:statusline_tab_warning = ""
		if !&modifiable
			return b:statusline_tab_warning
		endif
		let tabs = search('^\t', 'nw') != 0
		" find spaces that aren't used as alignment in the first indent
		" column
		let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
		if tabs && spaces
			b:statusline_tab_warning = '[mixed-indenting]'
		elseif (spaces && !&et) || (tabs && &et)
			b:statusline_tab_warning = '[%et]'
		endif
	endif
	return b:statusline_tab_warning
endfunction

" return a warning for "long lines" where "long" is either &textwidth or 80 (if
" no &textwidth is set)
" return '' if no long lines
" return '[#x,my,$z]' if long lines are found, were x is the number of long
" lines, y is the median length of the long lines and z is the length of the
" longest line
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

" return a list containing the lengths of the long lines in this buffer
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

function s:Median(nums)  " find the median of the given array of numbers
	let nums = sort(a:nums)
	let l = len(nums)
	if l % 2 == 1
		let i = (l - 1) / 2
		return nums[i]
	else
		return nums[l / 2] + nums[(l / 2) - 1] / 2
	endif
endfunction

set cmdheight=1
set laststatus=2
set statusline=%-03.f

set statusline+=%#warningmsg#  " display a warning if fileformat isn't unix
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

set statusline+=%#warningmsg#  " display a warning if file encoding isn't utf-8
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h             " help file flag
set statusline+=%y             " fivarype
set statusline+=%r             " read only flag
set statusline+=%m             " modified flag
" let fugitive_statisline_string = fugitive#statusline()
" set statusline+=fugitive_statisline_string

" display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%#error#        " display a warning if &paste is set
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=                                    " left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \  " current hightlight
set statusline+=%c,                                   " cursor column
set statusline+=%l/%L                                 " cursor line/total lines
set statusline+=\ %P                                  " percent through file

" recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

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
if &filetype == "python"
	set tabstop=4
	set expandtab
	set shiftwidth=4
elseif &filetype == "vim"
	set tabstop=4
	set shiftwidth=4
elseif &filetype == "html" || &filetype == "css"
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
Plug 'preservim/nerdtree'
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

