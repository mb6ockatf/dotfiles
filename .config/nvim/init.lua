-- init.lua - neovim configuration file
--
--   This program is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
--
--   This program is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--   GNU General Public License for more details.
--
--   You should have received a copy of the GNU General Public License
--   along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
o, api, cmd = vim.opt, vim.api, vim.cmd
o.background = 'dark'
o.confirm = true
o.number = true
o.title = true
o.mouse = ''
o.hlsearch = false
o.tabstop = 8
o.expandtab = false
o.relativenumber = true
o.wildignore:append {
	"*.pyc",
	"*/node_modules/*",
	"_site",
	"*/cache/*",
	"*/tmp/*",
	"*.out",
	"*/venv/*",
	"__pycache__",
	"*.opt-1",
	"*.opt-2",
	"*/target/*",
	"*/.log",
	"*/.aux",
	"*/.cls",
	"*/.aux",
	"*/.bbl",
	"*/.blg",
	"*/.fls",
	"*/.fdb*/",
	"*/.toc",
	"*/.out",
	"*/.glo",
	"*/.log",
	"*/.ist",
	"*/.fdb_latexmk",
	"configure",
	"*.in",
	"install-sh",
	"*.status",
	"compile",
	"*/autom4te.cache/*",
	"stamp-h1",
	"depcomp",
	"*.o",
	"*.scan",
}
o.bomb = false
o.linebreak = true
o.textwidth = 79
o.autoindent = true
o.cursorline = true
o.autowrite = true
o.history = 100
o.display = "truncate"
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.tabpagemax = 15
o.syntax = "on"
o.swapfile = false
o.backup = false
o.undofile = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"
o.colorcolumn = "79"
o.splitright = true
o.splitbelow = true
o.inccommand = 'split'
--[[
                     \\                                      [
                      @                 ⟡                  ╢
              /       ╣▒                                  ]▒       \\
             ╔       ]Ñ▒                                  ╟╣┐       ▓
            ╢╣       ╣▓            √          t            ▓╣       ▓╣
           ▓╣▒╖    ╓╫╜           ╥▓    UNIX    ▓@           ╙▓╖    ╔╣╢║
           ▓▓▓▓  ,p▓,,,,,,      ╜╙▓▄╖,      ,╓╥╜╙╙    ,,,,,,,,▓▓,  ▀▓▓╣U
           ▀▓Ö   ╙█▓▓▓▓▓▓╢╫╣▓▓▓▓▓╦, ▀▓▓╗  g╢▓╝ ,╓H╢╢╢╢╢╢▓▓▓▓▓▓▒▓╜   ]▓▓
            ▓▓▓╦╥╖ ╙╙╙╙`     `""▀▓▓@ ▐█▓L]▓╫╛ Æ▒╨╜"       ""╙╙` ╓╖∩▒▒▓
         ╒▓▒╜""╙▀▓▓                ▀  █▒Γ▐▓▓  ╩                ▓╢╜""╙▀█╫L
         ▐▌`      └╝                  ▓▒` █▓                  ╜       └█▓
        ▐▓                            ▓▒  █╢                           ▐▓
         ▐Γ                            ╛  ▐"                           ▐[
         ¬U                                                            jU
          C                                                            j
           L                                                          ]
--]]
cmd([[
filetype indent plugin on
syntax enable
set guicursor=n-v-c:block
]])
default_opts = {noremap = true, silent = true}
map = api.nvim_set_keymap
-- shift Y -- system clipper
map('v', 'S-Y', '"+y', {})
map('i', 'jj', '<Esc>', {noremap = true})
map('', '<up>', ':echoerr "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoerr "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoerr "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoerr "Use l"<CR>', {noremap = true, silent = false})
map('n', '<C-s>', ':w<CR>',  default_opts)
map('i', '<C-s>', '<esc>:w<CR>', default_opts)
map('n', '<Space>', '<PageDown> zz', default_opts)
map('n', '<C-Space>', '<PageUp> zz', default_opts)
help = "'F1 nothing\\n\\rF2 delete empty lines\\n\\rF3 edit init.lua\\n\\r"
help = help .. "F4 show this help message\\n\\rF5 set line numbers\\n\\r"
help = help .. "F6 free\\n\\rF7 previous tab\\n\\rF8 next tab\\n\\r"
help = help .. "F9 free\\n\\rF10 nothing\\n\\rF11 nothing'"
map('n', '<F1>', '', default_opts)
map('n', '<F2>', ':g/^$/d<CR>', default_opts)
map('n', '<F3>', ':execute "edit" stdpath("config") . "/init.lua"<CR>',
	default_opts)
map('n', '<F4>', ':lua print(' .. help .. ')<CR>', default_opts)
map('n', '<F5>', ':execute &nu==&rnu? "se nu!" : "se rnu!"<CR>',
	default_opts)
map('n', '<F6>',
	':lua print("This key (<F6>) is still not mapped to anything")<CR>',
	default_opts
)
map('n', '<F7>', ':tabprevious<CR>', default_opts)
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', default_opts)
map('n', '<F8>', ':tabnext<CR>', default_opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', default_opts)
map('n', '<F9>', ':tabnew<CR>', default_opts)
-- this key is usually controlled by the terminal
map('n', '<F10>', '', default_opts)
-- this key is usually controlled by the terminal
map('n', '<F11>', '', default_opts)
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', default_opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', default_opts)
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', default_opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', default_opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', default_opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', default_opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', default_opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', default_opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', default_opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', default_opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', default_opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', default_opts)
map('n', '<A-p>', '<Cmd>BufferPin<CR>', default_opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', default_opts)
map('n', '<C-p>',   '<Cmd>BufferPick<CR>', default_opts)
map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', default_opts)
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', default_opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', default_opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', default_opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', default_opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', default_opts)

function table.reduce(list, reducer, init)
	local accumulator = init
	for key, value in ipairs(list) do
		if key == 1 and not init then
			accumulator = value
		else
			accumulator = reducer(accumulator, value)
		end
	end
	return accumulator
end

function add(a, b) return a + b end

function nvim_add(opts)
	arguments = mfr.split(opts.fargs[1], " ")
	print(table.reduce(arguments, add, 0))
	return 0
end

function nvim_add_completion(ArgLead, CmdLine, CursorPos)
	return {"1", "100500"}
end

api.nvim_create_user_command(
	"Add",
	nvim_add,
	{
		nargs = 1,
		complete = nvim_add_completion
	}
)

function highlight_on_yank() vim.hl.on_yank() end

highlight_on_yank_group = api.nvim_create_augroup(
			'kickstart-highlight-yank',
			{clear = true}
		)

api.nvim_create_autocmd(
	'TextYankPost', {
		desc = 'Highlight when yanking (copying) text',
		group = highlight_on_yank_group,
		callback = highlight_on_yank
	}
)

require("config.lazy")
require("toggleterm").setup{
	open_mapping = [[<c-\>]],
	auto_scroll = true,
	clear_env = false,
	responsiveness = {
	    horizontal_breakpoint = 135,
	},
	insert_mappings = true,
	terminal_mappings = true,
	start_in_insert = true,
	shading_factor = 0,
	shading_ratio = 0,
}
