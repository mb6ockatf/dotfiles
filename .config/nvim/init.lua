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
---- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local o, api, cmd, hl, keymap, fn, g = vim.opt, vim.api, vim.cmd, vim.hl, vim.keymap, vim.fn, vim.g
local create_augroup = api.nvim_create_augroup
local create_autocmd = api.nvim_create_autocmd
o.undofile = true
o.clipboard = "unnamedplus"
g.mapleader, g.maplocalleader = " ", " "
g.vim_stats_data_dir = fn.stdpath("state") .. "/vim-stats"
g.loaded_node_provider, g.loaded_perl_provider = 0, 0
g.loaded_python3_provider, g.loaded_ruby_provider = 0, 0
o.confirm = true
o.number, o.relativenumber, o.title = true, true, true
o.mouse = ''
o.wildignore:append { "*.pyc", "*/node_modules/*", "_site", "*/cache/*", "*/tmp/*", "*/venv/*", "__pycache__", "*.opt-1", "*.opt-2", "*/target/*", "*.log", "*.aux", "*.cls", "*.bbl", "*.blg", "*.fls", "*.toc", "*.glo", "*.ist", "*.fdb_latexmk", "configure", "*.in", "install-sh", "*.status", "compile", "*/autom4te.cache/*", "stamp-h1", "depcomp", "*.o", "*.scan", }
o.linebreak = true
o.autowrite = true
o.cursorline = true
o.display = "truncate"
o.showmatch = true
o.ignorecase, o.smartcase = true, true
o.swapfile = false
o.scrolloff = 8
o.signcolumn = "yes"
o.splitright, o.splitbelow = true, true
o.inccommand = 'split'
o.autocomplete = true
o.complete = ".,w,b,u"
o.completeopt = { "menuone", "noselect", "fuzzy" }
o.pumheight = 10
o.guicursor = "n-v-c:block"
local default_opts = {silent = true}
keymap.set('i', 'jj', '<Esc>')
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Terminal: go left" })
keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Terminal: go down" })
keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Terminal: go up" })
keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Terminal: go right" })
keymap.set('n', '<C-s>', '<cmd>w<CR>',  default_opts)
keymap.set('i', '<C-s>', '<esc><cmd>w<CR>', default_opts)
keymap.set('n', '<F2>', '<cmd>g/^$/d<CR>', default_opts)
keymap.set('n', '<F3>', '<cmd>execute "edit" stdpath("config") . "/init.lua"<CR>', default_opts)
keymap.set('n', '<F5>', '<cmd>execute &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
keymap.set('n', '<F6>', function() print("<F6> not mapped") end, default_opts)
keymap.set('n', '<F7>', '<cmd>tabprevious<CR>', default_opts)
keymap.set('n', '<F8>', '<cmd>tabnext<CR>', default_opts)
keymap.set('n', '<F9>', '<cmd>tabnew<CR>', default_opts)
local highlight_on_yank_group = create_augroup( 'kickstart-highlight-yank', {clear = true})

create_autocmd('TextYankPost', {
		desc = 'Highlight when yanking (copying) text',
		group = highlight_on_yank_group,
		callback = hl.on_yank,
	}
)

-- Компиляция и запуск текущей задачи (a.cpp → make run-a)
keymap.set("n", "<leader>r", function()
    local file = fn.expand("%:t:r")
    cmd("write")
    cmd("!make -s run-" .. file)
end, { desc = "Compile and run current task" })

-- Только компиляция
keymap.set("n", "<leader>c", function()
    local file = fn.expand("%:t:r")
    cmd("write")
    cmd("!make -s " .. file)
end, { desc = "Compile current task" })

-- Сборка всего проекта
keymap.set("n", "<leader>m", "<cmd>write | !make -s<CR>", { desc = "Build all" })
create_autocmd("FileType", {
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})
-- ripgrep is not installed on purpose: :grep keeps the default 'grepprg' (plain grep),
-- so :checkhealth reports that as OK instead of warning (loading vim.health: ~0.2 ms)
do
  local health = vim.health
  local warn = health.warn
  health.warn = function(msg, ...)
    if msg == "ripgrep not available" then
      return health.ok("ripgrep not installed; :grep uses " .. vim.o.grepprg)
    end
    return warn(msg, ...)
  end
end
-- C/C++: clangd (editor only; builds stay on GCC). Per project: `bear -- make`
-- once, or a compile_flags.txt in the root. Ctrl-] jumps via LSP, K hover,
-- grr references, grn rename, gra code actions, ]d/[d next/prev diagnostic.
vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never", "-j=4" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  init_options = { fallbackFlags = { "-std=c23" } },
})
vim.lsp.enable("clangd")
create_autocmd("LspAttach", {
  group = create_augroup("lsp-completion", { clear = true }),
  callback = function(args) vim.bo[args.buf].complete = "o," .. vim.o.complete end,
})
vim.diagnostic.config({ virtual_text = true, severity_sort = true })
-- line length: prose wraps as you type (textwidth); code only gets a guide
-- (colorcolumn, one past the limit) and never wraps. An .editorconfig
-- max_line_length replaces the limit: still a wrap for prose, a guide for
-- everything else. Other file types (markdown, roff, ...)
-- have no limit and soft-wrap on screen (wrap + linebreak).
local wrap_at = { gitcommit = 72, mail = 72, text = 72, changelog = 72 }
local guide_at = {
  c = 80, cpp = 80, sh = 80, bash = 80, make = 80, m4 = 80, lua = 80,
  python = 80, awk = 80,
}
vim.filetype.add({ filename = { NEWS = "text", TODO = "text" } })
local function apply_line_length(buf)
  local ft = vim.bo[buf].filetype
  local project = vim.b[buf].editorconfig_max_line_length
  local wrap = wrap_at[ft] and (project or wrap_at[ft])
  local guide = project or guide_at[ft]
  vim.bo[buf].textwidth = wrap or 0
  local column = wrap and "+1" or (guide and tostring(guide + 1) or "")
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    api.nvim_set_option_value("colorcolumn", column, { scope = "local", win = win })
  end
end
require("editorconfig").properties.max_line_length = function(buf, value)
  vim.b[buf].editorconfig_max_line_length = tonumber(value)
  apply_line_length(buf)
end
create_autocmd({ "FileType", "BufWinEnter" }, {
  group = create_augroup("line-length", { clear = true }),
  callback = function(args) apply_line_length(args.buf) end,
})
require("lazy").setup({
  {
  "folke/tokyonight.nvim", lazy = false, priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors) colors.bg = "#000000" colors.bg_dark = "#000000" end,
    })
    vim.cmd.colorscheme("tokyonight")
  end,
  },
  {
	  --[[
	  --VimStats VimStatsTypos VimStatsUnused VimStatsMappings VimStatsCommands VimStatsClear
	  --]]
	  "AquiGorka/vim-stats", lazy = false,
	  config = function()
		  keymap.set("n", "<leader>vs", "<cmd>VimStats<CR>", { desc = "Vim usage stats" })
		  keymap.set("n", "<leader>vt", "<cmd>VimStatsTypos<CR>", { desc = "Detected typos" })
		  keymap.set("n", "<leader>vu", "<cmd>VimStatsUnused<CR>", { desc = "Unused mappings" })
	  end,
  },
  { "m4xshen/hardtime.nvim", lazy = false, dependencies = { "MunifTanjim/nui.nvim" }, opts = {max_time = 10000}, },
  {
	  "lewis6991/gitsigns.nvim",
	  opts = { signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" }, }, },
  },
}, {
  rocks = { enabled = false },
})
