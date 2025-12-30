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
o, api, cmd, log = vim.opt, vim.api, vim.cmd, vim.log
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

function highlight_on_yank() vim.highlight.on_yank() end

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

local function insert_text_at_cursor(text)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local line = vim.api.nvim_get_current_line()
    local new_line = line:sub(1, col) .. text .. line:sub(col + 1)
    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, {row + 1, col + #text})
end

local function cjk_notify(name, symbol, meaning, origin)
	vim.notify(
		'CJK: ' .. name ..
		' (' .. symbol .. ') ' ..
		'"' .. meaning .. '"' ..
		' (' .. origin .. ')',
		log.levels.INFO
	)
end

api.nvim_create_user_command(
	'CJK',
	function(opts)
		local h
		if opts.args == 'gongzuo' or opts.args == 'work' then
			h = '工作'
			insert_text_at_cursor(h)
			cjk_notify('gōngzuò', h, 'work', 'Chinese')
		elseif opts.args == 'yue' or opts.args == 'month' then
			h = '月'
			insert_text_at_cursor(h)
			cjk_notify('yuè', h, 'month', 'Chinese')
		elseif opts.args == 'ri' or opts.args == 'day' then
			h = '日'
			insert_text_at_cursor(h)
			cjk_notify('rì', h, 'day', 'Chinese')
		elseif opts.args == 'yiyue' or opts.args == 'january' then
			h = '一月'
			insert_text_at_cursor(h)
			cjk_notify('yīyuè', h, 'January', 'Chinese')
		elseif opts.args == 'eryue' or opts.args == 'february' then
			h = '二月'
			insert_text_at_cursor(h)
			cjk_notify('èryuè', h, 'February', 'Chinese')
		elseif opts.args == 'sanyue' or opts.args == 'march' then
			h = '三月'
			insert_text_at_cursor(h)
			cjk_notify('sānyuè', h, 'March', 'Chinese')
		elseif opts.args == 'siyue' or opts.args == 'april' then
			h = '四月'
			insert_text_at_cursor(h)
			cjk_notify('sìyuè', h, 'April', 'Chinese')
		elseif opts.args == 'wuyue' or opts.args == 'may' then
			h = '五月'
			insert_text_at_cursor(h)
			cjk_notify('wǔyuè', h, 'May', 'Chinese')
		elseif opts.args == 'liuyue' or opts.args == 'june' then
			h = '六月'
			insert_text_at_cursor(h)
			cjk_notify('liùyuè', h, 'June', 'Chinese')
		elseif opts.args == 'qiyue' or opts.args == 'july' then
			h = '七月'
			insert_text_at_cursor(h)
			cjk_notify('qīyuè', h, 'July', 'Chinese')
		elseif opts.args == 'bayue' or opts.args == 'august' then
			h = '八月'
			insert_text_at_cursor(h)
			cjk_notify('bāyuè', h, 'August', 'Chinese')
		elseif opts.args == 'jiuyue' or opts.args == 'september' then
			h = '九月'
			insert_text_at_cursor(h)
			cjk_notify('jiǔyuè', h, 'September', 'Chinese')
		elseif opts.args == 'shiyue' or opts.args == 'october' then
			h = '十月'
			insert_text_at_cursor(h)
			cjk_notify('shíyuè', h, 'october', 'Chinese')
		elseif opts.args == 'shiyiyue' or opts.args == 'november' then
			h = '十一月'
			insert_text_at_cursor(h)
			cjk_notify('shíyīyuè', h, 'November', 'Chinese')
		elseif opts.args == 'shieryue' or opts.args == 'december' then
			h = '十二月'
			insert_text_at_cursor(h)
			cjk_notify('shíèryuè', h, 'December', 'Chinese')
		elseif opts.args == 'zhouyi' or opts.args == 'monday' then
			h = '周一'
			insert_text_at_cursor(h)
			cjk_notify('zhōuyī', h, 'Monday', 'Chinese')
		elseif opts.args == 'zhouer' or opts.args == 'tuesday' then
			h = '周二'
			insert_text_at_cursor(h)
			cjk_notify('zhōuèr', h, 'Tuesday', 'Chinese')
		elseif opts.args == 'zhousan' or opts.args == 'wednesday' then
			h = '周三'
			insert_text_at_cursor(h)
			cjk_notify('zhōusān', h, 'Wednesday', 'Chinese')
		elseif opts.args == 'zhousi' or opts.args == 'thursday' then
			h = '周四'
			insert_text_at_cursor(h)
			cjk_notify('zhōusì', h, 'Thursday', 'Chinese')
		elseif opts.args == 'zhouwu' or opts.args == 'friday' then
			h = '周五'
			insert_text_at_cursor(h)
			cjk_notify('zhōuwǔ', h, 'Friday', 'Chinese')
		elseif opts.args == 'zhouliu' or opts.args == 'saturday' then
			h = '周六'
			insert_text_at_cursor(h)
			cjk_notify('zhōuliù', h, 'Saturday', 'Chinese')
		elseif opts.args == 'zhouqi' or opts.args == 'sunday' then
			h = '周七'
			insert_text_at_cursor(h)
			cjk_notify('zhōuqī', h, 'Sunday', 'Chinese')
		elseif opts.args == 'rili' or opts.args == 'calendar' then
			h = '日历'
			insert_text_at_cursor(h)
			cjk_notify('rìlì', h, 'calendar', 'Chinese')
		elseif opts.args == 'shengri' or opts.args == 'birthday' then
			h = '生日'
			insert_text_at_cursor(h)
			cjk_notify('shēngrì', h, 'birthday', 'Chinese')
		elseif opts.args == "yi" or opts.args == "1" then
			h = '一'
			insert_text_at_cursor(h)
			cjk_notify('yī', h, '1', 'Chinese')
		elseif opts.args == "er" or opts.args == "2" then
			h = '二'
			insert_text_at_cursor(h)
			cjk_notify('èr', h, '2', 'Chinese')
		elseif opts.args == "san" or opts.args == "3" then
			h = '三'
			insert_text_at_cursor(h)
			cjk_notify('sān', h, '3', 'Chinese')
		elseif opts.args == "si" or opts.args == "4" then
			h = '四'
			insert_text_at_cursor(h)
			cjk_notify('sì', h, '4', 'Chinese')
		elseif opts.args == "wu" or opts.args == "5" then
			h = '五'
			insert_text_at_cursor(h)
			cjk_notify('wǔ', h, '5', 'Chinese')
		elseif opts.args == "liu" or opts.args == "6" then
			h = '六'
			insert_text_at_cursor(h)
			cjk_notify('liù', h, '6', 'Chinese')
		elseif opts.args == "qi" or opts.args == "7" then
			h = '七'
			insert_text_at_cursor(h)
			cjk_notify('qī', h, '7', 'Chinese')
		elseif opts.args == "ba" or opts.args == "8" then
			h = '八'
			insert_text_at_cursor(h)
			cjk_notify('bā', h, '8', 'Chinese')
		elseif opts.args == "jiu" or opts.args == "9" then
			h = '九'
			insert_text_at_cursor(h)
			cjk_notify('jiǔ', h, '9', 'Chinese')
		elseif opts.args == "shi" or opts.args == "10" then
			h = '十'
			insert_text_at_cursor(h)
			cjk_notify('shí', h, '10', 'Chinese')
		end

	end,
	{ nargs = 1, desc = 'print desired CJK character by its\' pinyin'}
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
