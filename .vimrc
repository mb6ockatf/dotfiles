" Sun, 17 Jul 2022 23:31:04 +0300

set nocompatible number
set wrap linebreak textwidth=100 wrapmargin=0
set whichwrap+=<,>,h,l colorcolumn=80
set backspace=2
set autoindent
let color_list = ["darkblue", "morning", "shine", "evening"]
colorscheme default
let color_choice = strftime("%H") / 6
if colors_name !~ g:color_list[g:color_choice]
        execute "colorscheme " . g:color_list[g:color_choice]
endif
let b:edits = 0
function CheckFiletype()
        let b:edits += 1
        if &filetype == "" && b:edits > 20
                filetype detect
        elseif b:edits >= 200 || &filetype != ""
                autocmd! FiletypeDetection
        endif
endfunction
function PrepareBeforeWrite()
        :%s/\s\+$//e
	:%s/\^datetime\^/\=system("date -R")/e
endfunction
augroup FiletypeDetection
autocmd CursorMovedI * call CheckFiletype()
augroup END
augroup PreWriteEdits
autocmd BufWritePre * call PrepareBeforeWrite()
augroup END
syntax on
