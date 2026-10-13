#!/usr/bin/env bash
case $- in
	*i*) ;;
	*) return ;;
esac
set -o posix -o noclobber -o notify -o pipefail
command -v lesspipe > /dev/null && eval "$(SHELL=/bin/sh lesspipe)"
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.config/functions.sh ]] && . ~/.config/functions.sh
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ -z "$debian_chroot" && -r /etc/debian_chroot ]] && debian_chroot="$(< /etc/debian_chroot)" && export debian_chroot
[[ -r ~/.profile ]] && . ~/.profile
export LC_ALL=C POSIXLY_CORRECT=true CPU_NUMBER="$(($(getconf _NPROCESSORS_ONLN)))" NIX_BUILD_CORES=0 CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
export GORTEX_TOOLS=compact claude
alias sort="sort --parallel=${CPU_NUMBER}" parallel="parallel -j ${CPU_NUMBER}"
CFLAGS='-std=c23 -Wall -Wextra -Wpedantic -pedantic-errors -Werror -Wfatal-errors -g3' LDFLAGS='-lm'
COB_CFLAGS='-O0 -g -std=ibm-strict -fstatic-call -ffold-copy=lower -fdebugging -ftrace -fstack-check'
# drop each command both bare ("cd") and with arguments ("cd foo")
for c in cat cd ls rm cp mv rmdir mkdir man nvim vim less lesss lesst clear exit '[bf]g' tac rev apt make \
	echo factor indent clip chmod touch la ll pwd
do HISTIGNORE="${HISTIGNORE}:${c}:${c} *"
done
unset c
HISTIGNORE="${HISTIGNORE}:history*:*psk*:*password*"
shopt -s histappend cmdhist lithist histverify histreedit
HISTFILE="${HOME}/.bash_history" HISTSIZE=100000 HISTFILESIZE=200000
HISTCONTROL=ignoreboth HISTTIMEFORMAT='%F %T ' PROMPT_COMMAND='history -a'
export VMOPTIONS="${HOME}/.jetbrains.vmoptions.sh" CLICOLOR=1 GROFF_NO_SGR=1
export EDITOR=nvim VISUAL=nvim SUDO_EDITOR=nvim LIBPROC_HIDE_KERNEL=1
export GAWK_READ_TIMEOUT=60000 GAWK_SOCK_RETRIES=3 ENOENT=2 PROCPS_USERLEN=10
export LESS='-QR --use-color --wordwrap --wheel-lines=0 --no-keypad --no-histdups'
export MANPATH="${HOME}/.local/share/man:${MANPATH}" PYTHONSTARTUP="${HOME}/.config/pythonrc" GLOBSORT=none
export all_proxy=socks5h://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890
export no_proxy=localhost,127.0.0.1
export LESSSECURE=1 LESSCHARSET=utf-8 PAGER='less' MANPAGER='less' PYTHON_COLORS=1 PYTHONOPTIMIZE=true PYTHON_JIT=1
documents="${HOME}/Documents/" projects="${documents}/projects" notes="${projects}/notes" algs="${notes}/algs" solutions="${projects}/solutions" cf="${solutions}/codeforces"
CDPATH=":${notes}:${notes}/OSS:${projects}:${solutions}:${HOME}/.config:${HOME}"
shopt -s cdspell dirspell autocd
GCAL='--exit-status-help-non-zero --time-offset=+03:00 --atmosphere=991.915643,20 --precise --gregorian-reform=1918,02,01,13 --iso-week-number=yes -s 2 -X -G -K'
FGBLACK=$'\e[30m'             BGBLACK=$'\e[40m'             FGBLACKB=$'\e[90m'             BGBLACKB=$'\e[100m'
FGRED=$'\e[31m'               BGRED=$'\e[41m'               FGREDB=$'\e[91m'               BGREDB=$'\e[101m'
FGGREEN=$'\e[32m'             BGGREEN=$'\e[42m'             FGGREENB=$'\e[92m'             BGGREENB=$'\e[102m'
FGYELLOW=$'\e[33m'            BGYELLOW=$'\e[43m'            FGYELLOWB=$'\e[93m'            BGYELLOWB=$'\e[103m'
FGBLUE=$'\e[34m'              BGBLUE=$'\e[44m'              FGBLUEB=$'\e[94m'              BGBLUEB=$'\e[104m'
FGPURPLE=$'\e[35m'            BGPURPLE=$'\e[45m'            FGPURPLEB=$'\e[95m'            BGPURPLEB=$'\e[105m'
FGCYAN=$'\e[36m'              BGCYAN=$'\e[46m'              FGCYANB=$'\e[96m'              BGCYANB=$'\e[106m'
FGWHITE=$'\e[37m'             BGWHITE=$'\e[47m'	            FGWHITEB=$'\e[97m'             BGWHITEB=$'\e[107m'
FGCRIMSON=$'\e[38;5;160m'     BGCRIMSON=$'\e[48;5;160m'     FGCRIMSONB=$'\e[38;5;197m'     BGCRIMSONB=$'\e[48;5;197m'
FGTOMATO=$'\e[38;5;202m'      BGTOMATO=$'\e[48;5;202m'      FGTOMATOB=$'\e[38;5;209m'      BGTOMATOB=$'\e[48;5;209m'
FGORANGE=$'\e[38;5;208m'      BGORANGE=$'\e[48;5;208m'      FGORANGEB=$'\e[38;5;215m'      BGORANGEB=$'\e[48;5;215m'
FGAMBER=$'\e[38;5;214m'       BGAMBER=$'\e[48;5;214m'       FGAMBERB=$'\e[38;5;221m'       BGAMBERB=$'\e[48;5;221m'
FGGOLD=$'\e[38;5;220m'        BGGOLD=$'\e[48;5;220m'        FGGOLDB=$'\e[38;5;227m'        BGGOLDB=$'\e[48;5;227m'
FGLIME=$'\e[38;5;154m'        BGLIME=$'\e[48;5;154m'        FGLIMEB=$'\e[38;5;156m'        BGLIMEB=$'\e[48;5;156m'
FGCHARTREUSE=$'\e[38;5;118m'  BGCHARTREUSE=$'\e[48;5;118m'  FGCHARTREUSEB=$'\e[38;5;120m'  BGCHARTREUSEB=$'\e[48;5;120m'
FGEMERALD=$'\e[38;5;40m'      BGEMERALD=$'\e[48;5;40m'      FGEMERALDB=$'\e[38;5;42m'      BGEMERALDB=$'\e[48;5;42m'
FGMINT=$'\e[38;5;84m'         BGMINT=$'\e[48;5;84m'         FGMINTB=$'\e[38;5;86m'         BGMINTB=$'\e[48;5;86m'
FGSKY=$'\e[38;5;39m'          BGSKY=$'\e[48;5;39m'          FGSKYB=$'\e[38;5;75m'          BGSKYB=$'\e[48;5;75m'
FGAZURE=$'\e[38;5;33m'        BGAZURE=$'\e[48;5;33m'        FGAZUREB=$'\e[38;5;69m'        BGAZUREB=$'\e[48;5;69m'
FGCOBALT=$'\e[38;5;27m'       BGCOBALT=$'\e[48;5;27m'       FGCOBALTB=$'\e[38;5;63m'       BGCOBALTB=$'\e[48;5;63m'
FGNAVY=$'\e[38;5;21m'         BGNAVY=$'\e[48;5;21m'         FGNAVYB=$'\e[38;5;57m'         BGNAVYB=$'\e[48;5;57m'
FGVIOLET=$'\e[38;5;129m'      BGVIOLET=$'\e[48;5;129m'      FGVIOLETB=$'\e[38;5;141m'      BGVIOLETB=$'\e[48;5;141m'
FGORCHID=$'\e[38;5;135m'      BGORCHID=$'\e[48;5;135m'      FGORCHIDB=$'\e[38;5;177m'      BGORCHIDB=$'\e[48;5;177m'
FGROSE=$'\e[38;5;205m'        BGROSE=$'\e[48;5;205m'        FGROSEB=$'\e[38;5;211m'        BGROSEB=$'\e[48;5;211m'
FGBLUSH=$'\e[38;5;225m'       BGBLUSH=$'\e[48;5;225m'       FGBLUSHB=$'\e[38;5;231m'       BGBLUSHB=$'\e[48;5;231m'
END=$'\e[0m'                  BOLD=$'\e[1m'                 DIM=$'\e[2m'                   ITALIC=$'\e[3m'
UNDERLINE=$'\e[4m'            REVERSE=$'\e[7m'              STRIKETHROUGH=$'\e[9m'
export PS1="\[${BGPURPLEB}${FGBLACK}\]\$\[${END}\] "
export separator='────────────────────────────────────────────────────────────────────────────'
printf '
                     \\                                     [
                      @                 ⟡                  ╢
              /       ╣▒                                  ]▒       \\
             ╔       ]Ñ▒                                  ╟╣┐       ▓
            ╢╣       ╣▓            √          t            ▓╣       ▓╣
           ▓╣▒╖    ╓╫╜           ╥▓    UNIX    ▓@           ╙▓╖    ╔╣╢║
           ▓▓▓▓  ,p▓,,,,,,      ╜╙▓▄╖,      ,╓╥╜╙╙    ,,,,,,,,▓▓,  ▀▓▓╣U
           ▀▓Ö   ╙█▓▓▓▓▓▓╢╫╣▓▓▓▓▓╦, ▀▓▓╗  g╢▓╝ ,╓H╢╢╢╢╢╢▓▓▓▓▓▓▒▓╜   ]▓▓
            ▓▓▓╦╥╖ ╙╙╙╙`     `""▀▓▓@ ▐█▓L]▓╫╛ Æ▒╨╜"       ""╙╙` ╓╖∩▒▒▓
         ╒▓▒╜""╙▀▓▓                ▀  █▒Γ▐▓▓  ╩                ▓╢╜""╙▀█╫L
	 ▐▌`      └╝                  ▓▒` █▓                  ╜       └█▓
	 ▐▓                           ▓▒  █╢                           ▐▓
         ▐Γ                            ╛  ▐"                           ▐[
         ¬U                                                            jU
          C                                                            j
           L                                                          ]

'
