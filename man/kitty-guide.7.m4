m4_changequote([[,]])m4_changecom()m4_dnl
m4_dnl kitty-guide.7.m4 - source of kitty-guide(7); run "make man".
m4_dnl KEY(k1[, k2[, k3]]) starts an entry; quote a key that holds a comma,
m4_dnl as in KEY([[M+,]]).
m4_define([[KEY]], [[.TP
\fB$1\fP[[]]m4_ifelse([[$2]], [[]], [[]], [[, \fB$2\fP]])[[]]m4_ifelse([[$3]], [[]], [[]], [[, \fB$3\fP]])]])m4_dnl
'\" t
.TH KITTY-GUIDE 7 "2026-10-17" "dotfiles" "Personal Command Reference"
.SH NAME
kitty-guide \- a working guide to the kitty terminal emulator
.SH DESCRIPTION
\fBkitty\fP is a GPU-rendered terminal emulator.
Beyond showing a shell it does tabs and split panes, shows images,
opens and inserts URLs and paths from the keyboard, browses scrollback
in a pager, and talks to the shell to know where each prompt and each
command's output begins.
.PP
This page describes kitty 0.41 as installed here, with its default
bindings; \fBYOUR SETUP\fP lists what \fI~/.config/kitty/kitty.conf\fP
changes.
.PP
\fBM\fP means \fBkitty_mod\fP, which is Ctrl+Shift, so \fBM+t\fP is
Ctrl+Shift+T.
A \fB>\fP means \(lqthen\(rq: \fBM+p>f\fP is Ctrl+Shift+P, release,
then F.
.SS Words kitty uses
.TP
\fIOS window\fP
A real X11 window; bspwm tiles these.
.TP
\fItab\fP
A tab inside an OS window; the tab bar appears once there are two.
.TP
\fIwindow\fP
A pane inside a tab; kitty arranges panes with a \fIlayout\fP.
.TP
\fIkitten\fP
A small helper program shipped with kitty, run as \fBkitten\fP
\fIname\fP.
.PP
bspwm already tiles OS windows, so kitty's tabs and panes are
optional: open more OS windows with \fBM+n\fP instead.
Panes are handy when two shells belong together, say an editor and its
build.
.SH THE ESSENTIALS
KEY(M+c)
Copy the selection to the clipboard.
KEY(M+v)
Paste from the clipboard.
KEY(M+s, Shift+Insert)
Paste the primary selection (whatever is highlighted).
KEY(M+n)
New OS window; bspwm tiles it.
KEY(M+equal, M+minus)
Bigger or smaller font, in every window.
KEY(M+Backspace)
Reset the font size.
KEY(M+F11)
Toggle fullscreen.
KEY(M+F10)
Toggle maximized.
KEY(M+F1)
kitty's own documentation, offline, from the \fBkitty-doc\fP package.
KEY(M+Delete)
Reset the terminal, after a program left it garbled.
.PP
Selecting text with the mouse already copies it to the primary
selection, and a middle click pastes it.
That is the X11 way and usually faster than \fBM+c\fP and \fBM+v\fP.
.SH SCROLLBACK AND COMMAND OUTPUT
KEY(M+Up, M+Down)
Scroll one line; \fBM+k\fP and \fBM+j\fP do the same.
KEY(M+Page_Up, M+Page_Down)
Scroll one page.
KEY(M+Home, M+End)
Scroll to the top or the bottom.
KEY(M+h)
Open the whole scrollback in \fBless\fP(1): search with \fB/\fP,
\fBn\fP and \fBN\fP, quit with \fBq\fP.
KEY(M+g)
Open the output of the last command in \fBless\fP.
KEY(M+z, M+x)
Jump to the previous or next shell prompt.
KEY(Ctrl+Shift+right click)
Open the output of the clicked command in \fBless\fP.
.PP
\fBM+g\fP, \fBM+z\fP, \fBM+x\fP and the right click rely on shell
integration: kitty marks where each prompt and each output starts.
kitty injects it into bash by itself when it starts the shell.
For example, run \fBmake\fP, let it print 2000 lines, then press
\fBM+g\fP and search for \fB/error\fP instead of scrolling.
.PP
Each window keeps the last 20000 lines (\fBscrollback_lines\fP).
The pager is \fBless \-\-chop\-long\-lines \-\-RAW\-CONTROL\-CHARS\fP,
opened at the current position (\fBscrollback_pager\fP).
.SH HINTS: THE KEYBOARD INSTEAD OF THE MOUSE
Hints mark every matching thing on screen with a short label; type the
label to pick it.
KEY(M+e)
Open a URL in the browser.
KEY(M+p>f)
Insert a path at the cursor, for example a path from an error message
into the next command.
KEY(M+p>F)
Open a path (that is Shift+F).
KEY(M+p>l)
Insert a whole line.
KEY(M+p>w)
Insert a word.
KEY(M+p>h)
Insert a git hash: \fBgit log\fP, then \fBM+p>h\fP into \fBgit show\fP.
KEY(M+p>n)
Open \fIfile\fP:\fIline\fP from compiler or grep output in the editor,
at that line.
KEY(M+p>y)
Open a hyperlink.
.PP
Example: gcc prints \fIsrc/main.c:42:7: error: ...\fP; press
\fBM+p>n\fP, type the label, and nvim opens \fImain.c\fP at line 42.
.SH MOUSE
KEY(click on a URL)
Open it, unless text is selected.
KEY(Ctrl+Shift+click)
Open a link even inside programs that use the mouse themselves (nvim,
less, htop).
KEY(double click, triple click)
Select a word or a line.
KEY(Ctrl+Alt+drag)
Rectangular (block) selection, for columns.
KEY(right click)
Extend the selection to here.
KEY(middle click)
Paste the primary selection.
KEY(click in the prompt)
Move the text cursor there (shell integration).
.PP
When a program grabs the mouse (nvim with the mouse on, htop), hold
Shift to make kitty handle the click instead: \fBShift+drag\fP
selects, \fBShift+middle click\fP pastes.
.SH TABS
KEY(M+t)
New tab.
KEY(M+q)
Close the tab.
KEY(M+Right, M+Left)
Next or previous tab; \fBCtrl+Tab\fP and \fBCtrl+Shift+Tab\fP do the
same.
KEY(M+., [[M+,]])
Move the tab right or left.
KEY(M+Alt+t)
Rename the tab.
.SH PANES AND LAYOUTS
kitty calls panes \(lqwindows\(rq.
KEY(M+Enter)
New pane in this tab.
KEY(M+w)
Close the pane.
KEY(M+], M+[)
Next or previous pane.
KEY(M+1 ... M+0)
Jump to pane 1 ... 10.
KEY(M+F7)
Show a letter on each pane; type it to focus that pane.
KEY(M+F8)
Swap the current pane with one you pick.
KEY(M+f, M+b)
Move the pane forward or backward in the order.
KEY(M+`)
Move the pane to the top, the big slot.
KEY(M+r)
Resize mode: \fBw\fP/\fBn\fP wider or narrower, \fBt\fP/\fBs\fP taller
or shorter, \fBr\fP resets, hold Ctrl for bigger steps, Esc when done.
KEY(M+l)
Cycle the layouts.
.PP
The layouts, in the order \fBM+l\fP cycles them; a new tab starts in
\fIfat\fP:
.TP
\fIfat\fP
One big pane on top, the others side by side below.
.TP
\fIgrid\fP
All panes in an even grid.
.TP
\fIhorizontal\fP
All side by side.
.TP
\fIsplits\fP
Arbitrary splits; picking the split direction needs mappings in
kitty.conf.
.TP
\fIstack\fP
Only one pane visible, full size.
.TP
\fItall\fP
One big pane on the left, the others stacked on the right.
.TP
\fIvertical\fP
All stacked.
.PP
\fIstack\fP works as a zoom: \fBM+l\fP until \fIstack\fP, work,
\fBM+l\fP back.
.SH OTHER BUILT-IN TRICKS
KEY(M+u)
Type a Unicode character by name: search \(lqarrow\(rq, \(lqomega\(rq,
\(lqcheck mark\(rq; Enter inserts it.
KEY(M+F2)
Open kitty.conf in the editor.
KEY(M+F5)
Reload kitty.conf without restarting.
KEY(M+F6)
Show the effective configuration and what differs from the defaults.
KEY(M+Escape)
The kitty command shell; type \fBhelp\fP.
KEY(M+a>m, M+a>l)
More or less background opacity, which needs a compositor.
\fBM+a>1\fP makes it fully opaque, \fBM+a>d\fP resets it.
.SH KITTENS
Run these inside kitty.
.TP
\fBkitten icat\fP \fIpicture.png\fP
Show an image in the terminal.
.TP
\fBkitten diff\fP \fIold.c new.c\fP
Side-by-side diff with syntax colors; it works on directories and
images too.
Keys: \fBj\fP/\fBk\fP scroll, \fBn\fP/\fBN\fP next or previous change,
\fBq\fP quits.
.TP
\fBkitten ssh\fP \fIpi\fP
\fBssh\fP(1) that also copies kitty's terminfo and shell integration to
the remote side, so there is no more \(lqunknown terminal type\(rq.
Use it instead of plain ssh.
.TP
\fBkitten themes\fP
Browse and preview color themes live; Enter applies one, writing
\fIcurrent-theme.conf\fP.
.TP
\fBkitten choose-fonts\fP
Browse fonts with a live preview.
.TP
\fBkitten clipboard\fP
Read or write the clipboard from a shell, even over ssh:
.RS
.EX
make 2>&1 | kitten clipboard
kitten clipboard \-\-get\-clipboard
.EE
.RE
.TP
\fBkitten transfer\fP \fIfile\fP
Send files over the terminal itself, inside a \fBkitten ssh\fP session.
.TP
\fBkitten notify\fP \fItext\fP
Desktop notification from a script:
.RS
.EX
make; kitten notify "make: $?"
.EE
.RE
.TP
\fBkitten show-key\fP
Print what a key press sends, for debugging bindings in ble.sh, nvim
or tmux.
.TP
\fBkitten query-terminal\fP
Print what kitty supports.
.TP
\fBkitten @\fP \fIcommand\fP
Remote control; it needs \fBallow_remote_control\fP in kitty.conf.
.SH WHAT KITTY OFFERS OTHER PROGRAMS
.IP \(bu 2
True color (24-bit) and undercurl (wavy underlines in nvim).
.IP \(bu
The kitty graphics protocol: images in \fBkitten icat\fP, nvim plugins,
ranger-style file managers.
.IP \(bu
The kitty keyboard protocol: programs can tell Ctrl+I from Tab and
Ctrl+M from Enter, and see key releases (nvim uses it).
.IP \(bu
OSC 8 hyperlinks: \fBls \-\-hyperlink=auto\fP makes every file name
clickable, and gcc links its warnings to their documentation.
.IP \(bu
OSC 52 clipboard: programs such as tmux, or nvim over ssh, can set the
clipboard.
.IP \(bu
Ligatures: JetBrainsMono Nerd Font has them, so \fB\->\fP, \fB!=\fP and
\fB<=\fP render joined.
.IP \(bu
Nerd Font glyphs for icons in prompts and file listings.
.SH YOUR SETUP
.TP
\fIshell\fP
\fI~/.local/opt/bash/bin/bash\fP, a tuned bash 5.3, for interactive
kitty shells only.
.TP
\fIfont\fP
JetBrainsMono Nerd Font, 14 pt, ligatures always on.
.TP
\fItheme\fP
Tokyo Night Storm, from \fIcurrent-theme.conf\fP.
.TP
\fIscrollback\fP
20000 lines, the \fBless\fP pager described above.
.TP
\fIquiet\fP
No audio bell, a 1 ms visual bell, the mouse pointer never hides, URLs
are underlined with a curly line.
.TP
\fIkeys\fP
No bindings of its own; every key on this page is a kitty default.
\fBCtrl+Super+F\fP also toggles fullscreen.
.SH QUICK CARD
.TS
l l.
copy, paste	M+c  M+v, or select + middle click
new OS window	M+n
last command output	M+g
whole scrollback	M+h
jump between prompts	M+z  M+x
open URL, path:line	M+e  M+p>n
insert path	M+p>f
font size	M+=  M+\-  M+Backspace
tabs	M+t  M+q  M+Left  M+Right
panes	M+Enter  M+w  M+[  M+]  M+l (layout)
unicode by name	M+u
documentation	M+F1
.TE
.SH FILES
.TP
\fI~/.config/kitty/kitty.conf\fP
Personal settings, a symlink into the dotfiles.
.TP
\fI~/.config/kitty/current-theme.conf\fP
The theme written by \fBkitten themes\fP.
.SH SEE ALSO
\fBkitty\fP(1), \fBkitty.conf\fP(5), \fBreadlinebinds\fP(7),
\fBless\fP(1),
.UR https://sw.kovidgoyal.net/kitty/
.UE .
.PP
\fBM+F6\fP shows every binding in effect.
.SH AUTHOR
mb6ockatf <smokenmirror@tutamail.com>
