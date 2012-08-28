# .bashrc

echo "$(pwd)/.bashrc"

# Source global definitions on non Mac OS X machines
if [[ -f /etc/bashrc && "$(uname)" != "Darwin" ]]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# bash prompt with colors
# [ <user>@<hostname> <working directory> {current git branch (if you're in a repo)} ]
# $
PS1="\[\e[1;33m\][ \u@\h \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\[\e[1;36m\]\1\[\e[1;33m\]}/') ]\[\e[0m\]\n==> "

# execute only in Mac OS X
if [[ "$(uname)" == 'Darwin' ]]; then

	# if OS X has a ~/bin folder, then add it to PATH
	if [[ -d ~/bin ]]; then
		export PATH="$PATH:~/bin"
	fi

	alias ls='ls -G' # ls with colors

fi

alias ll='ls -lah' # long listing of all files with human readable file sizes

# run work machine rc
if [[ -f ~/.workbashrc ]]; then
	. ~/.workbashrc # super-secret work stuff
fi
