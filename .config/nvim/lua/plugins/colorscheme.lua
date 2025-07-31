--[[
colorscheme.lua -- setup tokyodark.nvim plugin with lazy plugin manager

it is a nice dark theme for neovim

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
return {
	"tiagovla/tokyodark.nvim",
	lazy = false,
	opts = {
		style = "night",
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			identifiers = { italic = false },
		},
	},
	config = function()
		vim.cmd("colorscheme tokyodark")
	end,
}
