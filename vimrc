" 7/24/2022 2:12:25 PM
" repository: https://github.com/mb6ockatf/cute-vimrc

se nocompatible nu nobomb
se wrap linebreak textwidth=100 wrapmargin=0 colorcolumn=100
se whichwrap+=<,>,h,l
se backspace=2
se autoindent
se laststatus=2
se statusline=%f%=%{&filetype}
let color_list = ["darkblue", "desert", "desert", "evening"]
colo default
let color_choice = strftime("%H") / 6
if colors_name !~ g:color_list[g:color_choice]
        execute "colorscheme " . g:color_list[g:color_choice]
endif
filetype detect
if &filetype == "python"
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
function PrepareBeforeWrite()
        %s/\s\+$//e
	%s/\^datetime\^/\=strftime("%c")/e
	se fenc=utf-8
endfunction
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
augroup END
syntax on

