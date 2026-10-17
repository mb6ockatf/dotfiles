m4_changequote([[,]])m4_changecom()m4_dnl
m4_dnl readlinebinds.7.m4 - source of readlinebinds(7); run "make man".
m4_dnl RLKEY(k1[, k2[, k3]]) starts an entry; hyphens become \- so the
m4_dnl keys copy and paste as typed.
m4_define([[RLKEY_ONE]], [[\fB[[]]m4_patsubst([[$1]], [[-]], [[\\-]])[[\fP]]]])m4_dnl
m4_define([[RLKEY]], [[.TP
RLKEY_ONE([[$1]])m4_ifelse([[$2]], [[]], [[]], [[, RLKEY_ONE([[$2]])]])m4_ifelse([[$3]], [[]], [[]], [[, RLKEY_ONE([[$3]])]])]])m4_dnl
.TH READLINEBINDS 7 "2026-10-17" "dotfiles" "Personal Command Reference"
.SH NAME
readlinebinds \- lesser known GNU Readline key bindings
.SH DESCRIPTION
Bash, and every other program built on GNU Readline (gdb, python3,
psql, rlwrap and many more), edits its input line with Readline.
Its default Emacs-mode bindings go far beyond the arrow keys; this page
lists the ones worth learning.
.PP
At the bash prompt here, ble.sh replaces Readline; it keeps most of
these keys and adds its own, see \fBblesh\-guide\fP(7).
This page still applies to the other programs, and to bash after
\fBble\-detach\fP.
.PP
\fBC\-\fP\fIx\fP means Control+\fIx\fP.
\fBM\-\fP\fIx\fP means Meta+\fIx\fP: hold Alt, or press and release Esc
before \fIx\fP.
\fBDEL\fP is the Backspace key.
.PP
Readline words are runs of letters and digits.
\fBC\-w\fP splits at white space instead, and the \fBshell\-\fP commands
(\fBM\-C\-f\fP, \fBM\-C\-b\fP, \fBM\-C\-d\fP, \fBM\-C\-t\fP) split the way bash
does, so a quoted string or \fIfile.tar.gz\fP counts as one word.
.SS Moving
RLKEY(M-f)
Move forward to the end of the next word.
RLKEY(M-b)
Move back to the start of the current or previous word.
RLKEY(M-C-f, M-C-b)
Move forward or back by shell word.
RLKEY(C-])
Read a character and move to its next occurrence.
RLKEY(M-C-])
Read a character and move to its previous occurrence.
RLKEY(C-x C-x)
Swap the cursor and the mark.
\fBC\-@\fP or \fBM\-SPC\fP sets the mark.
RLKEY(C-l)
Clear the screen and redraw the current line at the top.
RLKEY(M-C-l)
Clear the screen and the terminal scrollback, then redraw the current
line.
.SS History
RLKEY(M-<, M->)
Go to the first history line, or back to the line being typed.
RLKEY(C-r, C-s)
Incremental search backward or forward through the history.
Type to refine, repeat the key for the next match, \fBC\-g\fP to give up.
See \fBBUGS\fP about \fBC\-s\fP.
RLKEY(M-p, M-n)
Non-incremental search backward or forward: type the whole string,
then press Enter.
The string may match anywhere in a history line.
RLKEY(M-., M-_)
Insert the last argument of the previous command, like \fB!$\fP.
Repeat to step back through older commands.
With a numeric prefix (\fBM\-\fP\fIn\fP), insert the \fIn\fPth argument
instead.
RLKEY(M-C-y)
Insert the first argument of the previous command.
RLKEY(C-o)
Run the current line, then load the history line after it for editing.
Repeat to replay a sequence of commands one by one.
RLKEY(M-r)
Undo every change made to the current history line.
RLKEY(M-^)
Do history expansion (\fB!!\fP, \fB!$\fP, ...) on the line without
running it.
.SS Changing text
RLKEY(C-_, C-x C-u)
Undo the last change; repeat to undo further.
RLKEY(C-v, C-q)
Insert the next character typed literally, for example a Tab or
\fBC\-v\fP itself.
See \fBBUGS\fP about \fBC\-q\fP.
RLKEY(C-t)
Swap the two characters before and at the cursor.
RLKEY(M-t)
Swap the word before the cursor with the word after it.
RLKEY(M-C-t)
Same as \fBM\-t\fP for shell words.
RLKEY(M-u, M-l, M-c)
Uppercase, lowercase or capitalize the word from the cursor on.
RLKEY(M-\e)
Delete the spaces and tabs around the cursor.
RLKEY(M-#)
Comment out the line and enter it, so it is saved in the history but
not run.
.SS Killing and yanking
Killed text goes to the kill ring, not the X clipboard.
RLKEY(C-k)
Kill from the cursor to the end of the line.
RLKEY(C-u)
Kill from the cursor back to the start of the line.
RLKEY(M-d)
Kill to the end of the current or next word.
RLKEY(M-DEL, M-C-h)
Kill the word before the cursor.
RLKEY(M-C-d)
Kill to the end of the current or next shell word.
RLKEY(C-w)
Kill the white-space separated word before the cursor.
RLKEY(C-y)
Yank (paste) the most recent kill.
RLKEY(M-y)
Right after \fBC\-y\fP: replace the yanked text with the previous kill
in the ring.
.SS Expansion and completion
RLKEY(C-x *)
Replace the glob before the cursor with the files it matches.
\fBC\-x g\fP only lists them.
RLKEY(M-C-e)
Expand aliases, history, variables and substitutions in the whole line
without running it.
RLKEY(M-&)
Expand a tilde at the start of the word.
RLKEY(M-?, M-=)
List the possible completions.
RLKEY(M-*)
Insert all the possible completions.
RLKEY(M-/)
Complete the word as a file name, whatever the command.
.SH CUSTOM BINDINGS
\fI~/.inputrc\fP adds these on top of the defaults:
RLKEY(Up, Down)
Search the history backward or forward for lines that start with what
is already typed.
On an empty line they step through the history as usual.
RLKEY(TAB, S-TAB)
Cycle through the completions one at a time, forward or backward,
instead of only listing them.
RLKEY(SPC)
Perform history expansion on the word before the cursor, then insert a
space, so \fB!!\fP and \fB!$\fP show what they stand for before Enter.
RLKEY(C-x C-e)
Open the line in \fB$VISUAL\fP or \fB$EDITOR\fP (nvim) and run it on
exit.
Saving an empty file cancels.
RLKEY(C-x C-r)
Reload \fI~/.inputrc\fP.
.SH FILES
.TP
\fI~/.inputrc\fP
Personal Readline settings; it includes \fI/etc/inputrc\fP.
.SH BUGS
With terminal flow control on (the default), \fBC\-s\fP freezes the
terminal and \fBC\-q\fP unfreezes it, so neither reaches Readline.
Run \fBstty \-ixon\fP, for example in \fI~/.bashrc\fP, to free them.
ble.sh turns flow control off while it edits, so at its prompt both
keys work.
.SH SEE ALSO
\fBbash\fP(1), \fBreadline\fP(3), \fBstty\fP(1),
\fBblesh\-guide\fP(7),
\fBinfo rluserman\fP.
.PP
In bash, \fBbind \-p\fP lists every binding and \fBbind \-q\fP
\fIcommand\fP shows the keys for one command.
.SH AUTHOR
mb6ockatf <smokenmirror@tutamail.com>
