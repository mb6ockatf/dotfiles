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
opt, api, cmd = vim.opt, vim.api, vim.cmd
opt.confirm = true
opt.number = true
opt.mouse = ''
opt.hlsearch = false
opt.tabstop = 8
opt.relativenumber = true
opt.bomb = false
opt.linebreak = true
opt.textwidth = 79
opt.autoindent = true
opt.cursorline = true
opt.hi = 50
opt.timeout = false
opt.ttimeout = false
opt.display = truncate
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.tabpagemax = 15
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.colorcolumn = "79"
opt.splitright = true
opt.splitbelow = true
opt.inccommand = 'split'
--[[
                     \\                                      [           
                      @                 ⟡                  ╢             
              /       ╣▒                                  ]▒       \\    
             ╔       ]Ñ▒                                  ╟╣┐       ▓    
            ╢╣       ╣▓            √          t            ▓╣       ▓╣   
           ▓╣▒╖    ╓╫╜           ╥▓    NIXOS   ▓@           ╙▓╖    ╔╣╢║  
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
map('n', '<F8>', ':tabnext<CR>', default_opts)
map(
	'n',
	'<F9>', 
	':lua print("This key (<F9>) is still not mapped to anything")<CR>',
	default_opts
)
-- this key is usually controlled by the terminal
map('n', '<F10>', '', default_opts)
-- this key is usually controlled by the terminal
map('n', '<F11>', '', default_opts)

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

