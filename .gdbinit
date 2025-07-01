# .gdbinit - gdb configuration dotfile
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
set debuginfod enabled on
set disassembly-flavour intel
set listsize 10
set print array on
set print array-indexes on
set print pretty on
set print union on
set print demangle on
set multiple-symbols ask
set stop-on-solib-events 1
set print inferior-events on
set step-mode on
set breakpoint pending on
set print object on
set print static-members on
set print vtbl on
set demangle-style gnu-v3
set print sevenbit-strings off

set observer on
# instructions when using gdb:
# c-x,s enters tui mode.
# c/n/f/s/u/d/v/w in tui mode.
# c-x,c-a to exit tui mode.
# p/t var to print var as ntw,
# where t = c/i/x/..
# x/ntw where n=int, t=type, w=width to view memory.

