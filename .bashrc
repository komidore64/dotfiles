# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# bash prompt with colors
# [<user>@<hostname> <working directory> {current git branch} ]$
PS1="\[\e[1;33m\][\u@\h \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\[\e[1;36m\]\1\[\e[1;33m\]}/')]\$\[\e[0m\] "

alias ll='ls -lah'

# run work machine rc
if [ -f ~/.workbashrc ]; then
	. ~/.workbashrc
fi
