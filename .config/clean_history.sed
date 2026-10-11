# ~/.bash_history holds two formats:
#   old: one command per line
#   new: a "#<epoch>" timestamp line, then the command, which can span
#        several lines (shopt -s lithist)
# Every new-format entry is collected in the hold space and cleaned as a
# whole, so its timestamp stays attached to it.  Old lines get an empty
# "#" stamp while they are cleaned, so the same rules match both formats.

# timestamp line: start collecting a new entry, clean the previous one
/^#[0-9][0-9]*$/ {
	x
	/^$/ d
	b clean
}
# no timestamp seen yet: an old-format line, cleaned on its own
x
/^$/ {
	x
	s/^/#\n/
	b clean
}
# a line of the entry being collected
x
H
$ ! d
x

:clean
# remove sudo prefix, leave only sense of the command
s/^\(#[0-9]*\n\)sudo /\1/
# remove comments that somehow got to history
/^#[0-9]*\n#/ d
# remove some commands as they are all the same, nothing interesting
# need to do this after sudo correction
/^#[0-9]*\nmv / d
/^#[0-9]*\napt-fast remove / d
/^#[0-9]*\napt-fast install / d
/^#[0-9]*\ncat / d
/^#[0-9]*\ncd / d
/^#[0-9]*\nrm / d
/^#[0-9]*\nrmdir / d
/^#[0-9]*\nmkdir / d
/^#[0-9]*\nman / d
/^#[0-9]*\nnvim / d
/^#[0-9]*\nvim / d
/^#[0-9]*\nless / d
/^#[0-9]*\nclear / d
/^#[0-9]*\nexit / d
/^#[0-9]*\ntac / d
/^#[0-9]*\nrev / d
/^#[0-9]*\nfactor / d
/^#[0-9]*\nindent / d
/^#[0-9]*\nclip / d
/^#[0-9]*\nchmod / d
/^#[0-9]*\ntouch / d
/^#[0-9]*\napt-get / d
/^#[0-9]*\necho / d
/^#[0-9]*\nmake / d
/^#[0-9]*\ngit clone git@ / d
/^#[0-9]*\nlesss / d
/^#[0-9]*\nlesst / d
/^#[0-9]*\nls / d
/^#[0-9]*\n, / d
# remove pipes as every step of piping is a different command; each step
# becomes its own entry with the same timestamp.  Multi-line entries
# (loops, heredocs) are left whole.
/^#[0-9]*\n.*\n/ ! {
	:split
	s/^\(#[0-9]*\)\(\n.*\) | /\1\2\n\1\n/
	t split
	s/^\(#[0-9]*\)\(\n.*\) && /\1\2\n\1\n/
	t split
}
# drop the empty stamps given to old-format lines
s/^#\n//
s/\n#\n/\n/g
