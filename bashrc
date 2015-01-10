set -o vi

function __prompt {
    # sync history across terms
    history -a
    history -n
    # Get directory (and git-prompt) & generate term-wide hr
    DIR=`pwd|sed -e "s!$HOME!~!";__git_ps1 "(%s)"`
    #draw horizontal rule
    echo
    printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' \#
    echo
    echo $DIR
    case "$TERM" in
        *xterm* )
            # clear terminal title if set by application etc.
            echo -e "\033]0;\007"
        ;;
    esac
}
PROMPT_COMMAND="__prompt"
source ~/dotfiles/bash_colors
export __cr=$COLOR_RED
export __cc=$COLOR_CYAN
export __cw=$COLOR_WHITE
export __nc=$COLOR_NC #no color

# if shell's running INSIDE vim, mark it in the prompt (as a white V)
if [ -z ${VIMRUNTIME+x} ]; then export __vim="["; else __vim="(\[$__cw\]V\[$__cr\])-["; fi

export PS1="\[$__cr\]┌─[\[$__cc\]\D{%x %X}\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-$__vim\[$__cc\]\$>\[$__nc\]"
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

# enable color support of ls and also add handy aliases (ala ubuntu)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
fi

# Bins
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/bin:.:~/dotfiles/scripts:$PATH

