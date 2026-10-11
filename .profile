# ~/.profile - login environment
#
# Read by sh login shells, by the display manager's Xsession, and by every
# interactive bash through ~/.bashrc.  Keep it POSIX sh and idempotent: it
# runs again in every nested shell.
#
# Machine-specific additions go into ~/.profile.local, which is not tracked.
# It may call path_prepend.

path_prepend()
{
	case ":${PATH}:" in
		*":$1:"*) ;;
		*) PATH="$1${PATH:+:${PATH}}" ;;
	esac
}

path_prepend /usr/sbin
path_prepend /usr/local/sbin
path_prepend /usr/local/bin
path_prepend "${HOME}/.local/bin"
[ -r "${HOME}/.profile.local" ] && . "${HOME}/.profile.local"
export PATH
unset -f path_prepend
