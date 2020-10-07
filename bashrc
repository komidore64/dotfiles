# ~/.bashrc
# vim:ft=sh ts=4
#
# NOTE: prefer single brackets for tests where possible

# bail if this isn't a login shell
[ ! -t 0 ] && return

# start with some system-wide defaults
[ -f "/etc/bashrc" ] && source /etc/bashrc

# if there is a $HOME/bin folder, then add it to PATH
if [ -d "${HOME}/bin" ] && [[ ! ${PATH} =~ .*"${HOME}/bin".* ]]; then
    PATH="${PATH}:${HOME}/bin"
fi

# shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s histappend
if [ "${BASH_VERSION}" \> "4" ]; then
    shopt -s dirspell
    shopt -s checkjobs
fi

# stop the terminal from grabbing CTRL-s so i can forward- and reverse-search
# this enables XON/XOFF flow control (`man stty` for more info)
stty -ixon

export EDITOR='vim'
export PAGER='less'

# virtualenvwrapper
export WORKON_HOME=${HOME}/virtualenvs

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
alias fuck='(cmd="sudo $(history -p \!\!)"; echo ${cmd}; ${cmd})'
alias dadjoke='curl -H "Accept: text/plain" https://icanhazdadjoke.com -w "\n" --silent'
alias back='cd ../'

# git aliases
if which git &>/dev/null && [ "$(git --version | grep git | cut -d' ' -f3)" \> "1.7.2" ]; then
    alias g='git status --short --branch'
    alias gg='git status'
    alias gdw='git diff --word-diff'
else
    alias g='git status'
fi
alias b='git branch'
alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='cd $(git root)' #TODO: we don't want to cd if `git root` errors
# typos
alias girt='git'
alias gti='git'
alias gut='git'

if which fzf &> /dev/null; then
    export FZF_COMPLETION_TRIGGER=',,'
    # export FZF_DEFAULT_COMMAND='fd --type f'

    complete -o bashdefault -o default -o nospace -F _fzf_path_completion gd
    complete -o bashdefault -o default -o nospace -F _fzf_path_completion gds
    complete -o bashdefault -o default -o nospace -F _fzf_path_completion ga
    complete -o bashdefault -o default -o nospace -F _fzf_path_completion vimdiff
    complete -o bashdefault -o default -o nospace -F _fzf_path_completion tig
    # TODO: figure out path _and_ git-branch completion for tig
fi

if which libvirtd &> /dev/null; then
    export LIBVIRT_DEFAULT_URI=qemu:///system
fi

if which ansible-playbook &> /dev/null; then
    alias ap='ansible-playbook'
fi

if [ -f "${HOME}/.ssh/interop" ]; then
    alias sshinterop="ssh -i ${HOME}/.ssh/interop"
fi

if [ -d "${HOME}/workspace/Git-Mediawiki" ]; then
    alias mwgit="PERL5LIB=${PERL5LIB}${PERL5LIB:+':'}${HOME}/workspace/Git-Mediawiki git"
fi

# include RVM, if RVM is installed
if [ -d "${HOME}/.rvm" ]; then
    [[ ! ${PATH} =~ .*"${HOME}/.rvm/bin".* ]] && PATH="${PATH}:${HOME}/.rvm/bin"
    export rvmsudo_secure_path=0
    source ${HOME}/.rvm/scripts/rvm
fi

# include NVM, if NVM is installed
if [ -d "${HOME}/.nvm" ]; then
    export NVM_DIR="${HOME}/.nvm"
    [ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"  # This loads nvm
    [ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
fi

[ -f "${HOME}/.bash_colors" ] && source ~/.bash_colors

function __bashrc_prompt () {
    # good prompt article: http://www.askapache.com/linux/bash-power-prompt.html
    local pipestatus=${PIPESTATUS[@]}
    local branch=$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///' | awk -v len=15 '{ if (length($NF) > len) print substr($NF, 1, len-1)"…"; else print $NF}')
    local virtual_env=$(echo ${VIRTUAL_ENV} | awk -v len=15 -F'/' '{ if (length($NF) > len) print substr($NF, 1, len-1)"…"; else print $NF}')
    local prompt=''

    # FIXME: the above two awk calls seem to make prompt generation noticeably
    # slower. try lazing string manipulation instead. only do the git branch if
    # it's actually changed since last time. only do virtual_env if the global
    # variable is defined and it's changed since last time.

    # TODO show the username if he/she isn't the one who created the shell

    # pwd basename
    prompt+="${COLOR_PURPLE}\W${COLOR_RESET} "

    # show current git branch and any stashes
    if [ -n "${branch}" ]; then
        local stash_count=$(git stash list | wc -l)
        prompt+="git(${COLOR_GREEN}${branch}${COLOR_RESET}"
        if [ ${stash_count} -gt 0 ]; then
            prompt+=" ${COLOR_DARK_GRAY}st${COLOR_RESET}"
        fi
        prompt+=") "
    fi

    # virtualenv
    if [ -n "${VIRTUAL_ENV}" ]; then
        prompt+="py(${COLOR_YELLOW}${virtual_env}${COLOR_RESET}) "
    fi

    # exit status
    if [ $(( $(sed 's/ / + /g' <(echo ${pipestatus})) )) -gt 0 ]; then
        prompt+="${COLOR_RED}[${pipestatus}]${COLOR_RESET}"
    else
        prompt+="${COLOR_CYAN}\$${COLOR_RESET}"
    fi

    PS1=${prompt}' '
}
PS2="${COLOR_BOLD_PURPLE}>${COLOR_RESET} "
PS4="-> "

# bash history setup
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=9001
export HISTFILESIZE=9001
export PROMPT_COMMAND='__bashrc_prompt'
