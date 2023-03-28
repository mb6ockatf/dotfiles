#!/usr/bin/env bash
#
# ~/.bash_files/prompt.sh
#

set_bash_prompt () {
	LAST_RESULT=$?
	# Color codes for easy prompt building
	DIVIDER="\[\e[30;1m\]"
	COLOR_CMDCOUNT="\[\e[32;1m\]"    # green bold
	COLOR_USERNAME="\[\e[37;0m\]"    # white
	COLOR_USERHOSTAT="\[\e[36;1m\]"  # lightblueb
	COLOR_HOSTNAME="\[\e[35;1m\]"    # purple bold
	COLOR_GITBRANCH="\[\e[33;0m\]"   # yellow
	COLOR_VENV="\[\e[33;1m\]"        # yellow bold
	COLOR_PATH_OK="\[\e[32;1m\]"     # green bold
	COLOR_PATH_ERR="\[\e[31;1m\]"    # red bold
	COLOR_NONE="\[\e[0m\]"           # end
	# Change the path color based on return value
	if [ $LAST_RESULT -eq 0 ]
	then
		PATH_COLOR="$COLOR_PATH_OK"
	else
		PATH_COLOR="$COLOR_PATH_ERR"
	fi
	# Set the PS1 to be "[workingdirectory:commandcount"
	PS1="\n${DIVIDER}"
	PS1="${PS1}[${PATH_COLOR}\w${DIVIDER}"
	PS1="${PS1}:${COLOR_CMDCOUNT}\#${DIVIDER}"
	# Add git branch portion of the prompt, this adds ":branchname"
	GIT_IS_AVAILABLE=`git --version 2>&1 >/dev/null ; echo $?`
	if [ $GIT_IS_AVAILABLE -eq 0 ]
	then
		# Git is installed
		git_answer=`git rev-parse --is-inside-work-tree 2>&1 >/dev/null`
		if [ "$git_answer" = "" ]
		then
			# Inside of a git repository
			GIT_BRANCH=$(git symbolic-ref --short HEAD)
			PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${DIVIDER}"
		fi
	fi
	# Add Python VitualEnv portion of the prompt, this adds ":venvname"
	if ! [ -z "$VIRTUAL_ENV" ]
	then
		PS1="${PS1}:${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${DIVIDER}"
	fi
	# Close out the prompt, this adds "]\n[username@hostname] "
	PS1="${PS1}]\n${DIVIDER}[${COLOR_USERNAME}\u${COLOR_USERHOSTAT}@${COLOR_HOSTNAME}\h${DIVIDER}]${COLOR_NONE} "
}

export PROMPT_COMMAND=set_bash_prompt

