" ^datatime^
" repository: https://github.com/mb6ockatf/cute-vimrc

" se stands for set

" makes sure that VIM is using your .vimrc file, not system defaults
se nocompatible  " disable vi compatibility

se nu  " display line number
se nobomb  " do not write Byte Order Mark

" do not affect the contents, but how the file is displayed:
se wrap  " wraps displayed text
se linebreak  " breaks the line in two when it's too long; requires wrap = True

se textwidth=80  " line cannot be longer than that
" se wrapmargin=0 not needed when textwidth is set. Vi-compatible
se colorcolumn=80  " draw a coloured line at this width
" se whichwrap+=<,>l,h
se backspace=2  " allows backspace to go to the previous line
se autoindent
se laststatus=2  "show last window's status line
se statusline=%f%=%{&filetype}
let color_list = ["darkblue", "desert", "desert", "evening"]

" colo stands for colorscheme
colo default
let color_choice = strftime("%H") / 6
if colors_name !~ g:color_list[g:color_choice]
        execute "colorscheme " . g:color_list[g:color_choice]
endif
filetype detect
if &filetype == "python"
	" ia stands for iabbrev
	ia im import
	ia fr from
	ia pr print(
	ia inp input(
	ia ret return
	ia d def
	ia cl class
	ia init def init(
	ia """ """<CR>"""
	ia ex except
	ia t try:<CR>
	ia w with
end
" func stands for function
func PrepareBeforeWrite()
        %s/\s\+$//e
	%s/\^datetime\^/\=strftime("%c")/e
	se fenc=utf-8
" endf stands for endfunction
endf
" aug stands for augroup
aug PreWriteEdits
" au stands for autocmd
au BufWritePre * call PrepareBeforeWrite()
aug END
syntax on

