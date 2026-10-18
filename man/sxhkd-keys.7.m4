m4_changequote([[,]])m4_changecom()m4_dnl
m4_dnl sxhkd-keys.7.m4 - source of sxhkd-keys(7); run "make man".
m4_dnl KEY(k1[, k2[, k3]]) starts an entry; quote a key that holds a comma,
m4_dnl as in KEY([[S+,]]).
m4_define([[KEY]], [[.TP
\fB$1\fP[[]]m4_ifelse([[$2]], [[]], [[]], [[, \fB$2\fP]])[[]]m4_ifelse([[$3]], [[]], [[]], [[, \fB$3\fP]])]])m4_dnl
'\" t
.TH SXHKD-KEYS 7 "2026-10-18" "dotfiles" "Personal Command Reference"
.SH NAME
sxhkd-keys \- the desktop key bindings set in sxhkdrc
.SH DESCRIPTION
\fBsxhkd\fP is the hotkey daemon that runs beside \fBbspwm\fP.
bspwm itself reads no keys: every binding below is a line in
\fI~/.config/sxhkd/sxhkdrc\fP that runs a command, mostly \fBbspc\fP.
.PP
\fBS\fP means the Super (Windows) key, so \fBS+Return\fP is
Super+Enter.
\fBShift\fP, \fBCtrl\fP and \fBAlt\fP are spelled out.
\fBh j k l\fP are the directions left, down, up, right, as in vi;
the arrow keys mean the same where they appear.
.SS Words bspwm uses
.TP
\fInode\fP
A window, or a split holding two nodes; bspwm keeps each desktop as a
binary tree of them.
.TP
\fIdesktop\fP
A workspace; here they are numbered 1 to 8 on each monitor.
.TP
\fIpreselection\fP
A marked spot beside a window where the next window opens.
.SH PROGRAMS
KEY(S+Return)
Open a kitty window (\fB\-\-single\-instance\fP, so it starts fast).
KEY(XF86Calculator)
The calculator key also opens kitty.
KEY(S+d)
Application launcher: \fBrofi \-show drun\fP.
KEY(S+e)
Emoji picker (\fBrofimoji\fP).
KEY(S+v)
Clipboard history (\fBclipmenu\fP): pick an entry to copy it again.
KEY(S+Shift+v)
Delete entries from the clipboard history (\fBclipdelmenu\fP).
KEY(S+n)
Bring back the last dunst notification.
KEY(S+Shift+n)
Dismiss every notification.
KEY(S+Shift+s)
Screenshot of a selected area (\fBmaim \-s\fP): saved to
\fI~/Pictures/\fP as \fIdate_time\fP\fB.png\fP and copied to the
clipboard.
KEY(S+grave)
Show or hide the scratchpad: a floating, sticky kitty with class
\fBscratchpad\fP, started hidden by \fIbspwm/autostart.sh\fP.
(\fBgrave\fP is the \fB`\fP key, left of 1.)
.SH SESSION
KEY(S+x)
Lock the screen (\fBslock\fP).
KEY(S+Shift+e)
Power menu (\fI~/.config/rofi/powermenu.sh\fP).
KEY(S+Shift+r)
Restart bspwm in place, rereading \fIbspwmrc\fP; windows stay.
KEY(S+Escape)
Make sxhkd reread \fIsxhkdrc\fP.
Do this after editing the file.
.SH WINDOWS
KEY(S+Shift+q)
Close the focused window.
KEY(S+h, S+j, S+k)
Focus the window to the west, south or north; \fBS+l\fP for east.
KEY(S+Shift+h, S+Shift+j, S+Shift+k)
Swap the focused window with its west, south or north neighbour.
See \fBBUGS\fP for east.
KEY(S+c, S+Shift+c)
Focus the next or previous visible window on this desktop.
KEY(S+o, S+i)
Walk back or forward through the focus history.
KEY(S+Tab)
Focus the last focused window.
KEY(S+g)
Swap the focused window with the biggest one on the desktop.
KEY(S+p, S+b)
Focus the parent node, or the sibling (\fIbrother\fP) node.
KEY(S+comma, S+period)
Focus the first or second child of the focused split.
KEY(S+m)
Toggle the desktop between tiled and monocle (one window fills it).
.SS States and flags
KEY(S+Ctrl+m)
Toggle \fImarked\fP: a window you mean to move with \fBS+y\fP.
KEY(S+Ctrl+x)
Toggle \fIlocked\fP: \fBS+Shift+q\fP will not close it.
KEY(S+Ctrl+y)
Toggle \fIsticky\fP: it follows you to every desktop.
KEY(S+Ctrl+z)
Toggle \fIprivate\fP: bspwm keeps it where it is when placing new
windows.
KEY(S+y)
Send the newest marked window to the newest manual preselection.
.SH DESKTOPS AND MONITORS
KEY([[S+1 \(en S+8]])
Go to desktop \fIN\fP, on every monitor at once
(\fI~/.local/bin/bspc\-ws\fP); focus stays on the current monitor.
KEY([[S+Shift+1 \(en S+Shift+8]])
Send the focused window to desktop \fIN\fP of this monitor.
KEY(S+bracketleft, S+bracketright)
Previous or next desktop on this monitor (\fB[\fP and \fB]\fP).
KEY(S+Shift+Tab)
Go back to the last desktop.
KEY(S+Shift+Left, S+Shift+Down, S+Shift+Up)
Move the focused window to the monitor in that direction, and follow
it; \fBS+Shift+Right\fP for east.
.SH PRESELECT
Preselect a spot, then open or send a window; it lands there instead
of where bspwm would put it.
KEY(S+Ctrl+h, S+Ctrl+j, S+Ctrl+k)
Preselect west, south or north of the focused window;
\fBS+Ctrl+l\fP for east.
Press the same key again to cancel it.
KEY([[S+Ctrl+1 \(en S+Ctrl+9]])
Set the split ratio of the preselection to 0.1 \(en 0.9.
KEY(S+Ctrl+space)
Cancel the preselection of the focused window.
KEY(S+Ctrl+Shift+space)
Cancel every preselection on the desktop.
.SH MOVE AND RESIZE
Steps are 20 pixels.
KEY(S+Alt+h, S+Alt+j, S+Alt+k)
Grow the window by pushing its left, bottom or top edge outward;
\fBS+Alt+l\fP pushes the right edge.
KEY(S+Alt+Shift+h, S+Alt+Shift+j, S+Alt+Shift+k)
Shrink it by pulling its right, top or bottom edge inward;
\fBS+Alt+Shift+l\fP pulls the left edge.
KEY(S+Left, S+Down, S+Up)
Move a floating window; \fBS+Right\fP moves it right.
.SH HARDWARE KEYS
KEY(XF86MonBrightnessUp, XF86MonBrightnessDown)
Screen brightness up or down by 1% (\fBbrightnessctl\fP).
KEY(XF86AudioRaiseVolume, XF86AudioLowerVolume)
Volume of the default sink up or down by 1% (\fBpactl\fP).
KEY(XF86AudioMute)
Toggle mute.
.SH QUICK REFERENCE
.TS
l l.
terminal, launcher	S+Return  S+d
lock, power, reload	S+x  S+Shift+e  S+Escape
close window	S+Shift+q
focus, swap	S+hjkl  S+Shift+hjk
desktops	S+1..8  S+Shift+1..8  S+[  S+]
preselect	S+Ctrl+hjkl  S+Ctrl+space
resize	S+Alt+hjkl  S+Alt+Shift+hjkl
scratchpad	S+`
screenshot	S+Shift+s
clipboard, emoji	S+v  S+e
notifications	S+n  S+Shift+n
.TE
.SH FILES
.TP
\fI~/.config/sxhkd/sxhkdrc\fP
The bindings, a symlink into the dotfiles.
.TP
\fI~/.config/bspwm/bspwmrc\fP
bspwm settings and window rules.
.TP
\fI~/.local/bin/bspc\-ws\fP
Switches a desktop number on every monitor.
.SH BUGS
\fBS+Shift+l\fP is bound twice: to \fBslock\fP and, through
\fBS+Shift+{h,j,k,l}\fP, to swapping east.
sxhkd uses the first definition in the file, so it locks the screen
and there is no key for swapping east.
\fBS+x\fP locks the screen too.
.SH SEE ALSO
\fBsxhkd\fP(1), \fBbspwm\fP(1), \fBbspc\fP(1), \fBrofi\fP(1),
\fBkitty\-guide\fP(7).
.SH AUTHOR
mb6ockatf <smokenmirror@tutamail.com>
