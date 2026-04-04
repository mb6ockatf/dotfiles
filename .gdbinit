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
# .gdbinit - safer version
# format arrays with each element on a new line
set print array on
# show array indices when printing arrays
set print array-indexes on
# display structures with indentation and each field on separate lines
set print pretty on
# show unions in formatted output
set print union on
# print unlimited array elements
set print elements 0
# do not abbreviate repeated array elements
set print repeats 0
# stop printing strings at null characters
set print null-stop on
# always print addresses of referenced objects
set print address on
# print derived type of object for C++ pointers
set print object on
# print virtual function tables for C++ objects
set print vtbl on
# demangle names in assembly output
set print asm-demangle on
# show symbol names in disassembly
set print symbol on
# save command history between sessions
set history save on
set history filename ~/.gdb_history
# use GNU v3 C++ demangling
set demangle-style gnu-v3
# disable confirmation prompts
set confirm off
# lock scheduler to current thread during stepping
# set scheduler-locking step
# set multiple-symbols ask
set multiple-symbols ask
# set breakpoint pending off
set breakpoint pending off
# set tui border-kind acs
set tui border-kind acs
# set tui compact-source on
set tui compact-source on
# set pagination off
set pagination off
# auto-disassemble next line when stepping
set disassemble-next-line auto
# step into functions without debug info
set step-mode on
# follow child process after fork
set follow-fork-mode child
# follow child process after fork
set detach-on-fork off
# continue all threads, not just current
set schedule-multiple on
# prefer hardware watchpoints
set can-use-hw-watchpoints 1
# set hardware watchpoint limit
set remote hardware-watchpoint-limit 4
# auto-convert to hardware breakpoints
set breakpoint auto-hw on
# evaluate on host for remote
set breakpoint condition-evaluation host
# step into ASM functions without debug info
set step-mode on
# see ASM when stepping
set disassemble-next-line auto
# see all function arguments
set print frame-arguments all
# better watchpoint performance
set can-use-hw-watchpoints 1
