--[[
dashboard.lua -- setup dashboard.nvim plugin with lazy plugin
manager

it is a startup dashboard & file selector

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
local function configure_dashboard()
	require('dashboard').setup {
		theme = 'hyper',
		shortcut_type = 'letter',
		shuffle_letter = true,
		change_to_vcs_root = true,
		disable_move = true,
		config = {
			weak_header = {
				enable = true,
				concat = true,
				append = true,
			},
			disable_move = true,
			packages = { enable = false }
		},

	}
end


return {
	'nvimdev/dashboard-nvim',
	dependencies = { {'nvim-tree/nvim-web-devicons'}},
	event = 'VimEnter',
	config = configure_dashboard,
}

