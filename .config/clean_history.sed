# remove sudo prefix, leave only sense of the command
s/^sudo //
# remove pipes as every step of piping is a different command
s/ | /\n/g
s/ && /\n/g
s/vim /nvim /
# remove comments that somehow got to history
/^#/d
# remove some commands as they are all the same, nothing interesting
# need to do this after sudo correction
/^cd /d
/^rm /d
/^rmdir /d
/^mkdir /d
/^man /d
/^nvim /d
/^less /d
/^, /d
