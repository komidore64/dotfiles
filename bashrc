# ~/.bashrc
# vim:ft=sh ts=4
#
# NOTE: prefer single brackets for comparisons because that's more portable
# than double

[ ! -t 0 ] && return # bail if this isn't a login shell

[ -f "/etc/bashrc" ] && source /etc/bashrc

# if there is a $HOME/bin folder, then add it to PATH
[[ ! $PATH =~ "$HOME/bin" ]] && [[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"

# shell options yall
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
if [[ $BASH_VERSION > 4 ]]; then
    shopt -s dirspell
    shopt -s checkjobs
fi

# stop the terminal from grabbing CTRL-s so i can forward- and reverse-search
# this enables XON/XOFF flow control (`man stty` for more info)
stty -ixon

# if this is a raspberry pi
if [ -f "/boot/config.txt" ]; then
    alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
fi

# Let's cache the location of tmux's bash completion file so we don't have to
# wait forever to find it every time we open a new shell.
function __bashrc_tmux_setup () {
    # if tmux is installed
    if which tmux &> /dev/null; then
        local cache_file=$HOME"/.cache/dotfiles/tmux-completion"
        local tmux_completion=''
        if [ -f "$cache_file" ] && [ -f "$(cat $cache_file)" ]; then
            tmux_completion="$(cat $cache_file)"
        else
            tmux_completion="$(find /usr/ -name bash_completion_tmux.sh 2> /dev/null | head -n1)"
            mkdir -p $(dirname $cache_file)
            echo "$tmux_completion" > $cache_file
        fi
        [ -f "$tmux_completion" ] && source $tmux_completion
    fi
}
__bashrc_tmux_setup

export EDITOR='vim'
export PAGER='less'

alias ls='ls --color=auto --group-directories-first'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

alias l='ls'        # catch
alias s='ls'        # all
alias sl='ls'       # the
alias xit='exit'    # typos
alias ll='ls -lah'
alias tree='tree --dirsfirst -C'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'
alias grepr='grep --color=always'
alias lessr='less --RAW-CONTROL-CHARS'
alias tigl='tig $(git branch | sed -e "s/[\*\ ]//g")' # local branches
alias vim='vim -p'
alias lol='lolcat'
alias fuck='sudo $(history -p \!\!)'
alias dadjoke='curl https://icanhazdadjoke.com -w "\n" --silent'

if [ -d $HOME/workspace/obal ]; then
    alias obal-source="ANSIBLE_FORCE_COLOR=true PYTHONPATH=$HOME/workspace/obal python3 -m obal"
fi

# git aliases
if which git &>/dev/null && [ "$(git --version | grep git | cut -d' ' -f3)" \> "1.7.2" ]; then
    alias g='git status --short --branch'
    alias gg='git status'
    alias gdw='git diff --word-diff'
else
    alias g='git status'
fi
if which git-lfs &>/dev/null; then
    alias gls='git lfs status'
fi
alias b='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias girt='dadjoke'
alias gti='dadjoke'
alias gut='dadjoke'

# FZF
export FZF_COMPLETION_TRIGGER=',,'
complete -o bashdefault -o default -o nospace -F _fzf_path_completion gd
complete -o bashdefault -o default -o nospace -F _fzf_path_completion gds
complete -o bashdefault -o default -o nospace -F _fzf_path_completion ga

[[ -f ~/.bash_colors ]] && source ~/.bash_colors

function __bashrc_completion_files () {
    local f
    for f in ~/.completion/**; do source $f; done
}
__bashrc_completion_files

function __bashrc_prompt () {
    # good prompt article: http://www.askapache.com/linux/bash-power-prompt.html
    local pipestatus=${PIPESTATUS[@]}
    local prompt=''

    # TODO show the username if he/she isn't the one who created the shell

    # pwd basename
    prompt+=$COLOR_YELLOW"\W"$COLOR_RESET' '

    # exit status
    if [[ $(( $(sed 's/ / + /g' <(echo $pipestatus)) )) -gt 0 ]]; then
        prompt+=$COLOR_RED'['$pipestatus']'$COLOR_RESET
    else
        prompt+=$COLOR_GREEN'$'$COLOR_RESET
    fi

    PS1=$prompt' '
}
PS2="$COLOR_BOLD_PURPLE>$COLOR_RESET"
PS4="-> "

# bash history setup
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=9001
export HISTFILESIZE=9001
export PROMPT_COMMAND='__bashrc_prompt'

if which libvirtd &> /dev/null; then
    export LIBVIRT_DEFAULT_URI=qemu:///system

    if which vagrant &> /dev/null; then
        export VAGRANT_DEFAULT_PROVIDER=libvirt

        # vagrant aliases
        alias v="vagrant"
        alias vstatus="vagrant status"
        alias vup="vagrant up"
        alias vdestroy="vagrant destroy"
        alias vssh="vagrant ssh"
    fi
fi

if which ansible-playbook &> /dev/null; then
    alias ap='ansible-playbook'
fi

# include RVM, if RVM is installed
if [[ -d "$HOME/.rvm" ]]; then
    PATH=$PATH:$HOME/.rvm/bin
    export rvmsudo_secure_path=0
    source $HOME/.rvm/scripts/rvm
fi

# include NVM, if NVM is installed
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
