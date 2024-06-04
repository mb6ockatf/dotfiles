#function clear {sl -adF; /usr/bin/clear}
function login_bar {
	clear
	$text="POWERSHELL SUCKS; USE BASH OR SOME OTHER NORMAL SHELL"
	toilet --font future $text -w 80 --metal
}
login_bar

# function cal {cal | pv -qL 10}
# set-alias cat        get-content
new-alias clear      clear-host
new-alias cp         copy-item
new-alias kill       stop-process
new-alias lp         out-printer
new-alias ls         get-childitem
new-alias mount      new-mshdrive
new-alias mv         move-item
new-alias ps         get-process
new-alias rm         remove-item
new-alias rmdir      remove-item

function help {
    get-help $args[0] | out-host -paging
}

function man {
    get-help $args[0] | out-host -paging
}

function mkdir {
    new-item -type directory -path $args
}

function prompt {
    "PS " + $(get-location) + "> "
}

& {
    for ($i = 0; $i -lt 26; $i++)
    {
        $funcname = ([System.Char]($i+65)) + ':'
        $str = "function global:$funcname { set-location $funcname } "
        invoke-expression $str
    }
}

function todo {todo.sh -@ -+ -c -t -v}
function shellcheck {shellcheck -C}
function parrot {curl parrot.live}
# function cowsay {/usr/bin/cowsay -d -W 80}
function moo {fortune | cowsay | pv -qL 30}
# function cp {cp -i}
# function df {df -h}
# function free {free -h}
function np {nano -w PKGBUILD}
# function less {/usr/bin/less --use-color}
New-Alias more less
# function ls {ls --color=auto}
# function rm {rm -ivI --preserve-root}
# function ln {ln -i}
function scp {echo "scp is deprecated, use rsync"}
# function chown {chown --preserve-root}
# function chmod {chmod --preserve-root}
# function chgrp {chgrp --preserve-root}
# function grep {grep --colour=auto}
# function egrep {grep -E --colour=auto}
# function fgrep {grep -F --colour=auto}
function dig {echo "use drill"}
function netstat {echo "netstat: idk deprecated or not, but use ss"}
function ifconfig {echo "ifconfig is deprecated with net-tools pkg. use ip a"}
function arp {echo "arp is deprecated with net-tools pkg. use ip n"}
function nslookup {echo "nslookup is deprecated. use drill or host"}
function iptunnel {echo "iptunnel is deprecated with net-tools pkg. use ip t"}
function ipmaddr {echo "ipmaddr is deprecated with net-tools pkg. use ip maddr"}
function nameif {echo "nameif is deprecated with net-tools pkg. use ip l"}
function route {echo "route is deprecated with net-tools pkg. use ip r"}
function iwconfig {echo "iwconfig not deprecated yet, but buggy. use iw"}
function poweroff {systemctl poweroff}
function halt {systemctl halt}
function reboot {systemctl reboot}
function pip {python3 -m pip}
function google-chrome {/usr/bin/google-chrome-stable %U}
function commit {gum_commit}
function sha1 {openssl sha1}
# function mkdir {/usr/bin/mkdir -pv}
#function mount {/usr/bin/mount | column -t}
function h {cat .bash_history | sort | uniq -c | sort -nr}
function j {jobs -l}
# function ping {ping -c 5}
function fastping {ping -c 100 -i 0.2}
function ping8 {ping 8.8.8.8}
function meminfo {free -l}
function psmem {ps auxf | sort -nr -k 4}
function psmem10 {ps auxf | sort -nr -k 4 | head -10}
function pscpu {ps auxf | sort -nr -k 3}
function pscpu10 {ps auxf | sort -nr -k 3 | head -10}
New-Alias cpuinfo lscpu
function gpumeminfo {grep -i --color memory /var/log/Xorg.0.log}
#function wget {/usr/bin/wget -c}
