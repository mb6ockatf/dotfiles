:a; /;$/! { N; s/\n/ /; ba };
s/[[:space:]][[:space:]]*/ /g;
/^[[:space:]]/d;

s/extern //g; s/const //g; s/__attribute__ //g; s/__restrict //g;
s/__ssize_t/ssize_t/g;

s/ ((.*//; s/ __asm__.*//;

/^int _/d; /^ssize_t __/d; /^typedef /d; /^struct /d; /^}/d; /^{/d;
/^__extension__ /d; /^static /d; /^enum {/d;

s/__ptr,/pointer,/g; s/__ptr)/pointer)/g; s/__ptr\[/pointer\[/g;
s/__buf,/buffer,/g; s/__buf)/buffer)/g; s/__buf\[/buffer\[/g;
s/__s,/string,/g; s/__s)/string)/g; s/__s\[/string\[/g;
s/__c,/character,/g; s/__c)/character)/g; s/__c\[/character\[/g;
s/__fd,/fd,/g; s/__fd)/fd)/g; s/__fd\[/fd\[/g;
s/__pos,/position,/g; s/__pos)/position)/g; s/__pos\[/position\[/g;
s/__src,/source,/g; s/__src)/source)/g; s/__src\[/source\[/g;
s/__dest,/destination,/g; s/__dst)/destination)/g; s/__dst\[/destination\[/g;
s/__s1,/string1,/g; s/__s1)/string1)/g; s/__s1\[/string1\[/g;
s/__s2,/string2,/g; s/__s2)/string2)/g; s/__s2\[/string2\[/g;

s/__//g;
