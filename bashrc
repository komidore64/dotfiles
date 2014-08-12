# ~/.bashrc
# vim:ft=sh
#
# DISCLAIMER: i am a bash noob

function __bashrc_home_bin_path () {
    # if there is a $HOME/bin folder, then add it to PATH
    if [[ (! $PATH =~ "$HOME/bin") && -d "$HOME/bin" ]]; then
        PATH="$PATH:$HOME/bin"
    fi
}

shopt -s cdspell
if [[ $BASH_VERSION > 4 ]]; then
    shopt -s dirspell
    shopt -s checkjobs
fi

# stop the terminal from grabbing CTRL-s so i can forward- and reverse-search
# this enables XON/XOFF flow control (`man stty` for more info)
stty -ixon

# if this is not OS X
if ! which sw_vers > /dev/null 2>&1; then

    # load /etc/bashrc
    if [[ -f "/etc/bashrc" ]]; then
        . /etc/bashrc
    fi

fi

# if this is OS X
if which sw_vers > /dev/null 2>&1; then

    __bashrc_home_bin_path

    alias ls='ls -G' # ls with colors
    alias which='which -a' # mac/bsd 'which'

fi

# if this is a raspberry pi
if [[ -f /boot/config.txt ]]; then

    __bashrc_home_bin_path

    # basic aliases
    alias ls='ls --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

fi

# if this is a nitrous.io box
if [[ $(whoami) == "action" ]]; then

    __bashrc_home_bin_path

    # basic aliases
    alias ls='ls --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias which='which -a' # dumb 'which'

    if [[ -f ~/.timezone ]]; then
        source ~/.timezone
    fi

fi

# include RVM, if RVM is installed
if [[ -d "$HOME/.rvm" ]]; then
    PATH=$PATH:$HOME/.rvm/bin
fi

function __bashrc_tmux_setup () {
    # if tmux is installed
    if which tmux > /dev/null 2>&1; then

        # source tmux bash completion, if it exists
        local tmux_completion=$(find /usr/ -name bash_completion_tmux.sh 2> /dev/null | head -n1)
        if [[ -f $tmux_completion ]]; then
            source $tmux_completion
        fi

    fi
}
__bashrc_tmux_setup

export EDITOR='vim'
export PAGER='less'

alias l='ls'        # catch
alias s='ls'        # all
alias sl='ls'       # the
alias xit='exit'    # typos
alias ll='ls -lah'
alias tree='tree -C'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias grepr='grep --color=always'
alias lessr='less --RAW-CONTROL-CHARS'
alias tiga='tig --all'
alias tigl='tig $(git branch | sed -e "s/[\*\ ]//g")' # local branches
alias vim='vim -p'
alias lol='lolcat'

alias git='hub' # hook into hub

# git aliases
alias g='git status'
alias gd='git diff'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias gdw='git diff --word-diff'
alias girt='git' # typo catch

if [[ -f ~/.bash_colors ]]; then
    source ~/.bash_colors
fi

function __bashrc_completion_files () {
    # source bash-completion files
    local f
    for f in ~/.completion/**; do source $f; done
}
__bashrc_completion_files

function __bashrc_prompt () {
    # good prompt article: http://www.askapache.com/linux/bash-power-prompt.html
    local exitstatus=$?
    local prompt=''

    # TODO show a user if he/she isn't the one who created the shell

    # working directory
    if [[ $PWD != $HOME ]]; then
        prompt+=$COLOR_YELLOW$(pwd | awk -F/ '{print $NF}')$COLOR_RESET' '
    fi

    # exit status
    if [[ $exitstatus -ne 0 ]]; then
        prompt+=$COLOR_RED$'\xe2\x9c\x98'$COLOR_RESET # U+2718 "heavy ballot x"
    else
        prompt+=$COLOR_LIGHT_GREEN$'\xe2\x96\xb6'$COLOR_RESET # U+25B6 "right-pointing triangle"
    fi

    PS1=$prompt' '
    PS2='\xe2\x86\xb3'' ' # U+21B3 "downwards arrow with tip rightwards"
}


shopt -s histappend
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=9001
export HISTFILESIZE=9001
export PROMPT_COMMAND='__bashrc_prompt'

if ( which vagrant > /dev/null 2>&1 && which libvirtd > /dev/null 2>&1 ); then
    export VAGRANT_DEFAULT_PROVIDER=libvirt
fi
