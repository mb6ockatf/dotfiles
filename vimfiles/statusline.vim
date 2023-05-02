" Thu Apr 20 13:11:45 2023 | repository: https://github.com/mb6ockatf/dotfiles
" functions required for generating statusline. should be sourced in vimrc

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
