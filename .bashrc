# .bashrc

if [[ "$(uname)" != "Darwin" ]]; then # non mac os x

    # source global bashrc
    if [[ -f "/etc/bashrc" ]]; then
        . /etc/bashrc
    fi

    export TERM='xterm-256color' # probably shouldn't do this
fi

# bash prompt with colors
# [ <user>@<hostname> <working directory> {current git branch (if you're in a repo)} ]
# ==>
PS1="\[\e[1;33m\][ \u\[\e[1;37m\]@\[\e[1;32m\]\h\[\e[1;33m\] \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\[\e[1;36m\]\1\[\e[1;33m\]}/') ]\[\e[0m\]\n==> "

# execute only in Mac OS X
if [[ "$(uname)" == 'Darwin' ]]; then

    # if OS X has a $HOME/bin folder, then add it to PATH
    if [[ -d "$HOME/bin" ]]; then
        export PATH="$PATH:$HOME/bin"
    fi

    alias ls='ls -G' # ls with colors

fi

alias ll='ls -lah' # long listing of all files with human readable file sizes
alias tree='tree -C' # turns on coloring for tree command
alias mkdir='mkdir -p' # create parent directories as needed
alias vim='vim -p' # if more than one file, open files in tabs

export EDITOR='vim'

# super-secret work stuff
if [[ -f "$HOME/.workbashrc" ]]; then
    . $HOME/.workbashrc
fi

# Add RVM to PATH for scripting
if [[ -d "$HOME/.rvm/bin" ]]; then # if installed
    PATH=$PATH:$HOME/.rvm/bin
fi
