" Tue 19 Jul 2022 01:18:55 PM MSK

se nocompatible number
se wrap linebreak textwidth=100 wrapmargin=0
se whichwrap+=<,>,h,l colorcolumn=100
se backspace=2
se autoindent
se laststatus=2
set statusline=%f%=%{&filetype}
let color_list = ["darkblue", "morning", "desert", "evening"]
colo default
let color_choice = strftime("%H") / 6
if colors_name !~ g:color_list[g:color_choice]
        execute "colorscheme " . g:color_list[g:color_choice]
endif
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
let b:edits = 0
function CheckFiletype()
        let b:edits += 1
        if &filetype == "" && b:edits > 10
                filetype detect
        elsei b:edits >= 200 || &filetype != ""
                autocmd! FiletypeDetection
        end
endfunction
function PrepareBeforeWrite()
        %s/\s\+$//e
	%s/\^datetime\^/\=strftime("%c")/e
endfunction
augroup FiletypeDetection
autocmd CursorMovedI * call CheckFiletype()
augroup END
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
augroup END
syntax on
