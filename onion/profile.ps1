function login_bar {
	clear
	$text="POWERSHELL SUCKS; USE BASH OR SOME OTHER NORMAL SHELL"
	toilet --font future $text -w 80 --metal
}
login_bar

# function cal {cal | pv -qL 10}

function todo {todo.sh -@ -+ -c -t -v}
function shellcheck {shellcheck -C}
function parrot {curl parrot.live}
# function cowsay {cowsay -d -W 80}
function moo {fortune | cowsay | pv -qL 30}
function full_update {yay -Syuu --noconfirm}
function update {yay -Syuu }
# function cp {cp -i}
# function df {df -h}
# function free {free -h}
function np {nano -w PKGBUILD}
# function less {less --use-color}
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
# function clear {sl -adF; clear}
New-Alias py python3
function pip {python3 -m pip}
New-Alias vi vim
New-Alias edit vim
New-Alias emacs vim
function google-chrome {/usr/bin/google-chrome-stable %U}
function status {git status}
function pull {git pull}
function push {git push}
function add {git add}
function rebase {git rebase}
function clone {git clone}
function branch {git branch}
function log {git log}
function tag {git tag}
function merge {git merge}
function restore {git restore}
function commit {gum_commit}
function sha1 {openssl sha1}
New-Alias echoi rev
# function mkdir {mkdir -pv}
# function mount {mount | column -t}
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
# function wget {wget -c}
function clip {xclip -sel clip}
function :wq {exit}
function :x {exit}
function ZZ {exit}
New-Alias pacman yay
