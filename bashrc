# ~/.bashrc

if [[ "$(uname)" != "Darwin" ]]; then # non mac os x

    # load /etc/bashrc
    if [[ -f "/etc/bashrc" ]]; then
        . /etc/bashrc
    fi

fi

# bash prompt
# <working directory>(<git branch>) $
PS1="\[\e[0;33m\]\h\[\e[0m\] \W\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/(\[\e[1;96m\]\1\[\e[0m\])/') $ "

# execute only in Mac OS X
if [[ "$(uname)" == 'Darwin' ]]; then

    # if there is a $HOME/bin folder, then add it to PATH
    if [[ -d "$HOME/bin" ]]; then
        export PATH="$PATH:$HOME/bin"
    fi

    alias ls='ls -G' # ls with colors
    alias which='which -a'

fi

if [[ -f /boot/config.txt ]]; then # if this is a raspberry pi

    # if there is a $HOME/bin folder, then add it to PATH
    if [[ -d "$HOME/bin" ]]; then
        export PATH="$PATH:$HOME/bin"
    fi

    alias ls='ls --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

fi

# Add RVM to PATH for scripting, if RVM is installed
if [[ -d "$HOME/.rvm/bin" ]]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# check to see if tmux is installed
which tmux > /dev/null 2>&1
if [[ $? == 0 ]]; then

    # source tmux bash completion, if it exists
    tmux_completion=$(find /usr/share/ -name bash_completion_tmux.sh 2> /dev/null) # this is not very efficient
    if [[ -f $tmux_completion ]]; then
        source $tmux_completion
    fi

fi

# git
function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git st
    fi
}
alias gd='git diff'
alias ga='git add'
alias gap='git add --patch'


alias ll='ls -lah' # long listing of all files with human readable file sizes
alias tree='tree -C' # turns on coloring for tree command
alias mkdir='mkdir -p' # create parent directories as needed
alias grepr='grep --color=always' # grep with color forced to ON
alias lessr='less -R' # less with raw color interpretation (for use with grepc)
alias tiga='tig --all' # show all branches/tags/etc
alias tigl='tig $(git branch | sed -e "s/[\*\ ]//g")' # local branches
alias vim='\vim -p' # if more than one file, open files in tabs

export EDITOR='vim'
