--[[
lazy.lua -- set up nvim plugin manager called lazy

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system(
		{ "git", "clone", "--filter=blob:none", "--branch=stable",
			lazyrepo, lazypath }
	)
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			},
			true, {}
		)
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup(
	{
		spec = { { import = "plugins" }, },
		install = { colorscheme = { "habamax" } },
		checker = { enabled = true },
	}
)
