set -o vi
export TERM=xterm-256color

# TMUX
#if which tmux 2>&1 >/dev/null; then
#    # if no session is started, start a new session
#    test -z ${TMUX} && tmux
#
#    # when quitting tmux, try to attach
#    while test -z ${TMUX}; do
#        tmux attach || break
#    done
#fi

# login message
if which fortune > /dev/null; then
     if which cowsay > /dev/null; then
        fortune -as | cowsay
     else
        fortune -as
    fi
fi

# get aliases
source ~/dotfiles/bash_aliases

function __prompt {
    # sync history across terms
    history -a
    history -n
    # Get directory (and git-prompt) & generate term-wide hr
    DIR=`pwd|sed -e "s!$HOME!~!";__git_ps1 "(%s)"`
    #this depends on the calc function
    cols=`calc $(tput cols) - ${#DIR}`
    echo
    echo -n $DIR
    for ((x = 0; x < cols; x++)); do
        printf %s -
    done
    # clear terminal title if set by application etc.
    # echo -e "\033]0;\007"
}
PROMPT_COMMAND="__prompt"
export __cr='\e[0;31m' #red
export __cc='\e[0;36m' #cyan
export __nc='\e[0m'    #no color

export PS1="\[$__cr\]┌─[\[$__cc\]\D{%x %X}\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-[\[$__cc\]\$>\[$__nc\]"
export PS2="\[$__cr\]└─\[$__cc\]>\[$__nc\]"

# git-prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

#fix history
export HISTCONTROL=ignoredups             # no duplicate entries
export HISTSIZE=10000                     # big history
export HISTFILESIZE=10000                 # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                       # append to history, not overwrite it
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
#shopt -s dirspell                         # spellcheck for directories

# Grep Colors
export GREP_OPTIONS='--color=auto' GREP_COLOR='00;38;5;157'

# ps + grep (via egghead on freenode#web)
function pgrep(){ ps -ax | grep $1 | grep -v "grep"; }
# why not history
function hgrep(){ history | grep $1 | grep -v "grep"; }

#simple calculator
function calc () { echo "$*" | bc -l; }

# easy unzip
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
     else
        echo "'$1' is not a valid file"
     fi
}

#git propt
source ~/dotfiles/scripts/git-prompt.sh

# git completion
source ~/dotfiles/scripts/git-completion.bash

export NODE_PATH="/usr/local/lib/node"
export GEM_HOME=~/gems
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="~/dotfiles/scripts:~/gems/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# MacPorts Installer: adding an appropriate PATH variable for use with MacPorts.
PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
#node path
PATH="/usr/local/share/npm/bin:$PATH"
#GAE path
PATH="/Applications/GoogleAppEngineLauncher.app/Contents/Resources/GoogleAppEngine-default.bundle/Contents/Resources/google_appengine:$PATH"

export PATH
