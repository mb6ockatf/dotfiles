m4_changequote([[,]])m4_changecom()m4_dnl
m4_dnl blesh-guide.7.m4 - source of blesh-guide(7); run "make man".
m4_dnl KEY(k1[, k2[, k3]]) starts an entry; quote a key that holds a comma
m4_dnl or a parenthesis, as in KEY([[C-x (]]).
m4_define([[KEY]], [[.TP
\fB$1\fP[[]]m4_ifelse([[$2]], [[]], [[]], [[, \fB$2\fP]])[[]]m4_ifelse([[$3]], [[]], [[]], [[, \fB$3\fP]])]])m4_dnl
'\" t
.TH BLESH-GUIDE 7 "2026-10-17" "dotfiles" "Personal Command Reference"
.SH NAME
blesh-guide \- a working guide to the ble.sh line editor for bash
.SH DESCRIPTION
\fBble.sh\fP replaces Readline, the line editor inside bash.
Everything typed at the prompt goes through it: highlighting,
suggestions, completion menus, multi-line editing.
Bash itself is unchanged; scripts, aliases and functions behave exactly
as before.
.PP
\fBC-\fP\fIx\fP is Ctrl+\fIx\fP, \fBM-\fP\fIx\fP is Alt+\fIx\fP,
\fBS-\fP is Shift, \fBRET\fP is Enter.
The keys were checked against the live bindings of ble.sh 0.4.0-devel4
on this machine.
.SH READING THE SCREEN
The command line is colored as you type: commands by kind (builtin,
alias, function, file), strings, variables, redirections.
Two cues matter in practice:
.IP \(bu 2
A command name that does not exist shows in the error style, so a typo
is visible before Enter.
.IP \(bu
Existing file names are underlined; a path that is not underlined does
not exist (yet).
.PP
After a command finishes, ble.sh may print a status line of its own:
.TP
\fB[ble: exit 1]\fP
The last command failed with status 1.
.TP
\fB[ble: elapsed 6.0s (CPU 0.1%)]\fP
The command ran for 5 s or longer (\fBexec_elapsed_enabled\fP in
\fI~/.blerc\fP).
A high CPU percentage means it was working, a low one that it waited on
disk, network or sleep.
.PP
The current time shows at the right edge of the prompt
(\fBprompt_rps1\fP).
.SH AUTOSUGGESTIONS
While you type, ble.sh proposes the rest of the line in dim text, taken
from the history and from completion.
Keep typing to ignore it, or take it:
KEY(Right, C-f, End)
Accept the whole suggestion; \fBC-e\fP does the same.
KEY(M-f, C-Right)
Accept one word of it.
KEY(C-j, C-RET)
Accept it and run the command at once.
KEY(C-g)
Dismiss it.
.PP
A habit worth building: type the first letters of a command run
yesterday, glance at the grey text, press Right or \fBC-j\fP.
.SH COMPLETION MENU
\fBTAB\fP completes.
With several candidates a menu appears below the line, and \fBTAB\fP
cycles through it, filling each candidate in place.
KEY(TAB, S-TAB)
Next or previous candidate.
KEY(arrows, C-n C-p C-f C-b)
Move around the grid.
KEY(PgUp, PgDn)
Page through a long menu.
KEY(typing)
Narrows the menu to what still matches.
KEY(RET)
Accept the candidate; it does \fInot\fP run the command.
KEY(C-g)
Cancel and restore what was typed.
.PP
Inside the menu these change the layout:
KEY(C-x d)
Descriptions next to the candidates, good for options.
KEY(C-x l)
One candidate per line.
KEY(C-x c)
A dense grid.
KEY(C-x a)
Back to the default aligned grid.
KEY(C-x Right, C-x Left)
Cycle through the layouts.
.PP
Targeted completion, for when the context guess is wrong:
KEY(C-x /)
Complete a file name here.
KEY(C-x !)
Complete a command name here.
KEY(C-x $)
Complete a variable name here.
KEY(C-x @, C-x ~)
Complete a host name or a user name here.
KEY(M-TAB)
Complete from words in the history.
KEY(C-x *)
Expand the glob under the cursor in place: type \fBrm *.o\fP, then
\fBC-x *\fP to see exactly what will go.
\fBC-x g\fP only lists the matches.
KEY(C-x C-r)
Dabbrev: complete from words seen in earlier commands.
.SH MULTI-LINE EDITING
\fBRET\fP on an unfinished command (an open quote, an \fBif\fP without
\fBfi\fP, a \fBfor\fP without \fBdone\fP) inserts a newline instead of
running it, which gives a real multi-line editor:
KEY(C-p, C-n)
Move between the lines of the command; past the first or last line
they step through the history.
\fBUp\fP and \fBDown\fP search the history instead, because
\fI~/.inputrc\fP binds them to prefix search.
KEY(RET)
New line, while the buffer has several lines.
KEY(C-j)
Run the whole thing.
KEY(M-RET)
Force a newline anywhere, even in a complete command.
.PP
The status line shows \fB\-\- MULTILINE \-\-\fP as a reminder.
Pasting several lines lands here too, instead of running them one by
one.
When a command outgrows the prompt, \fBC-x C-e\fP opens it in nvim;
save and quit to run it.
.SH HISTORY
KEY(Up, Down)
Prefix search: type \fBgit c\fP, press Up, and only entries starting
with \fBgit c\fP come back.
On an empty line they walk the history as usual.
KEY(C-Up, C-Down)
Plain history, one entry at a time.
KEY(C-x p, C-x n)
Substring search backward or forward: the typed text may appear
anywhere in the entry.
KEY(C-r)
Fuzzy history search with fzf; see \fBfzf\-guide\fP(7).
KEY(C-s)
Incremental search forward.
ble.sh turns terminal flow control off while editing, so \fBC-s\fP
reaches it.
KEY(M-.)
Insert the last argument of the previous command; press again to go
further back.
KEY(C-o)
Run this line and load the next history entry.
Recall the first of a sequence of commands and press \fBC-o\fP
repeatedly to replay them.
KEY(Space)
Expands \fB!!\fP, \fB!$\fP and \fB^old^new\fP in place, so the real
command shows before it runs.
.SH EDITING
The Emacs keys from Readline still work (see \fBreadlinebinds\fP(7)),
plus a few extras.
KEY(C-a, C-e)
Start or end of the line.
KEY(M-b, M-f)
Word back or forward.
KEY(C-w)
Kill the word before the cursor, or the selection.
KEY(M-d)
Kill the word after the cursor.
KEY(C-k, C-u)
Kill to the end or the start of the line.
KEY(C-y)
Paste what was killed.
KEY(M-w)
Copy the selection without killing it.
KEY(S-arrows)
Select text, as in a GUI editor; \fBS-Home\fP and \fBS-End\fP too.
KEY(C-Space)
Set the mark; \fBC-x C-x\fP jumps between the mark and the cursor.
KEY(C-_, C-x C-u)
Undo, many levels; \fBC-x U\fP redoes.
KEY(M-r)
Throw away all edits to this history line.
KEY(M-u)
Uppercase the next word.
KEY(M-z \fIchar\fP)
Delete up to \fIchar\fP.
KEY(C-] \fIchar\fP)
Jump to the next \fIchar\fP.
KEY([[C-x (]], [[C-x )]])
Start and end recording a keyboard macro; \fBC-x e\fP replays it.
.SH HELP ON THE SPOT
KEY(F1)
Help for the command under the cursor: its man page, or its
\fB\-\-help\fP output.
Type \fBtar \-\fP, then F1, while hunting for the right option.
.SH VI MODE
\fBset \-o vi\fP switches to ble.sh's vi mode, a real subset of vim
rather than Readline's bare one: text objects (\fBciw\fP,
\fBdi"\fP, \fBca(\fP), visual mode (\fBv\fP, \fBV\fP), registers, the
\fB.\fP repeat, counts and \fBu\fP undo.
\fBset \-o emacs\fP switches back.
.SH CONTROLLING BLE.SH
.TP
\fBble-detach\fP
Fall back to plain Readline in this shell, for a misbehaving terminal
or program.
.TP
\fBble-attach\fP
Turn ble.sh back on.
.TP
\fBble-reload\fP
Reload after editing \fI~/.blerc\fP.
.TP
\fBble-update\fP
Upgrade ble.sh from upstream.
.TP
\fBble-bind \-P\fP
List every key binding; grep it when wondering whether there is a key
for something.
.TP
\fBC-x C-v\fP
Print the ble.sh and bash versions.
.SH FINDING THINGS
.TS
l l.
ran it before, remember how it starts	type it, Up
ran it before, remember a fragment	C-r
typing it now	the grey suggestion: Right, C-j
an argument you can't spell	the TAB menu
a path deep in the tree	C-t, or **TAB
a directory to go to	M-c
a list to choose from	| fzf
.TE
.PP
Both tools only change how a command line is reached.
What runs is still plain bash with GNU tools, so nothing learned here
locks you in.
.SH FILES
.TP
\fI~/.blerc\fP
ble.sh settings: the right-hand clock, the elapsed-time threshold, and
the fzf integrations.
.TP
\fI~/.local/share/blesh/\fP
The ble.sh installation, loaded from \fI~/.bashrc\fP.
.TP
\fI~/.inputrc\fP
Readline settings; ble.sh reads its bindings too, which is where the
Up and Down prefix search comes from.
.SH SEE ALSO
\fBbash\fP(1), \fBfzf\-guide\fP(7), \fBreadlinebinds\fP(7),
\fBkitty\-guide\fP(7),
.UR https://github.com/akinomyoga/ble.sh/wiki
.UE .
.SH AUTHOR
mb6ockatf <smokenmirror@tutamail.com>
