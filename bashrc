set -o vi

# login message
if which fortune > /dev/null; then
     if which cowsay > /dev/null; then
        fortune -as | cowsay
     else
        fortune -as
    fi
fi


function __prompt {
    # sync history across terms
    history -a
    history -n
    # Get directory (and git-prompt) & generate term-wide hr
    DIR=`pwd|sed -e "s!$HOME!~!";__git_ps1 "(%s)"`
    #draw horizontal rule
    echo
    printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' \#
    echo -n $DIR
    case "$TERM" in
        *xterm* )
            # clear terminal title if set by application etc.
            echo -e "\033]0;\007"
        ;;
    esac
}
PROMPT_COMMAND="__prompt"
source ~/dotfiles/bash_colors
export __cr=$COLOR_RED #red
export __cc=$COLOR_CYAN #cyan
export __nc=$COLOR_NC #no color

export PS1="\[$__cr\]┌─[\[$__cc\]\D{%x %X}\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-[\[$__cc\]\$>\[$__nc\]"
export PS2="\[$__cr\]└─\[$__cc\]>\[$__nc\]"

# git-prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

#fix history
export HISTCONTROL=ignoredups             # no duplicate entries
export HISTSIZE=100000                     # big history
export HISTFILESIZE=20000                 # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                       # append to history, not overwrite it
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
#shopt -s dirspell                         # spellcheck for directories

# search-path for CD command
export CDPATH=".:~:~/projects:~/Dropbox/projects"

# Grep Colors
export GREP_OPTIONS='--color=auto' GREP_COLOR='00;38;5;157'

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

# git prompt
source ~/dotfiles/scripts/git-prompt.sh

# git completion
source ~/dotfiles/scripts/git-completion.bash

# node completion
source ~/dotfiles/scripts/npm-completion.bash

# get aliases
source ~/dotfiles/bash_aliases


export PATH=$PATH:~/dotfiles/scripts


