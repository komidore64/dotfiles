# ~/.bashrc
# vim:ft=sh
#
# DISCLAIMER: i am a bash noob

[ ! -t 0 ] && return # bail if this isn't a login shell

function __bashrc_home_bin_path () {
    # if there is a $HOME/bin folder, then add it to PATH
    [[ ! $PATH =~ "$HOME/bin" ]] && [[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"
}

function __bashrc_basic_common_aliases () {
    alias ls='ls --color=auto --group-directories-first'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
}
__bashrc_basic_common_aliases

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
    [[ -f "/etc/bashrc" ]] && source /etc/bashrc

fi

# if this is OS X
if which sw_vers > /dev/null 2>&1; then

    __bashrc_home_bin_path

    alias ls='ls -G' # ls with colors
    alias which='which -a'

fi

# if this is a raspberry pi
if [[ -f "/boot/config.txt" ]]; then

    __bashrc_home_bin_path
    alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

fi

# if this is a nitrous.io box
if [[ $(whoami) == "action" ]]; then

    __bashrc_home_bin_path
    alias which='which -a'

    [[ -f "$HOME/.timezone" ]] && source $HOME/.timezone

fi

# include RVM, if RVM is installed
[[ -d "$HOME/.rvm" ]] && PATH=$PATH:$HOME/.rvm/bin

function __bashrc_tmux_setup () {
    # if tmux is installed
    if which tmux > /dev/null 2>&1; then

        # source tmux bash completion, if it exists
        local tmux_completion=$(find /usr/ -name bash_completion_tmux.sh 2> /dev/null | head -n1)
        [[ -f $tmux_completion ]] && source $tmux_completion

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

# git aliases
if which git &>/dev/null && [[ "$(git --version | grep git | cut -d' ' -f3)" > 1.7 ]]; then
    alias g='git status --short --branch'
else
    alias g='git status'
fi
alias gd='git diff'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias gdw='git diff --word-diff'
alias girt='git'
alias gti='git'

alias git='hub' # hook into hub

[[ -f ~/.bash_colors ]] && source ~/.bash_colors

function __bashrc_completion_files () {
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
        prompt+=$COLOR_LIGHT_GREEN'$'$COLOR_RESET
    fi

    PS1=$prompt' '
    PS2="-> "
}


shopt -s histappend
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=9001
export HISTFILESIZE=9001
export PROMPT_COMMAND='__bashrc_prompt'

if ( which vagrant > /dev/null 2>&1 && which libvirtd > /dev/null 2>&1 ); then
    export VAGRANT_DEFAULT_PROVIDER=libvirt
fi
