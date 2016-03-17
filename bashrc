# set readline to be vi-like
set -o vi

#
# source external files
# fzf, git, npm, bashisms
#

source ~/dotfiles/bash_colors
source ~/dotfiles/bash_aliases
source ~/dotfiles/bash_functions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/dotfiles/scripts/git-prompt.sh
source ~/dotfiles/scripts/git-completion.bash
source ~/dotfiles/scripts/npm-completion.bash

#
# setup prompt
#

function __prompt {
    # sync history across terms
    history -a
    history -n
    # Get directory (and git-prompt) & generate term-wide hr
    DIR=$(pwd|sed -e "s!$HOME!~!";__git_ps1 "(%s)")
    #draw horizontal rule
    echo
    printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#'
    echo
    echo "$DIR"
    case "$TERM" in
        *xterm* )
            # clear terminal title if set by application etc.
            echo -e "\033]0;\007"
        ;;
    esac
}
PROMPT_COMMAND="__prompt"
export __cr=$COLOR_RED
export __cc=$COLOR_CYAN
export __cw=$COLOR_WHITE
export __nc=$COLOR_NC #no color
# if shell's running INSIDE vim, mark it in the prompt (as a white V)
if [ -z "${VIMRUNTIME}" ]; then
  export __vim="[";
else
  export __vim="(\[$__cw\]V\[$__cr\])-[";
fi
# git-prompt settings
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
# set prompt
export PS1="\[$__cr\]┌─[\[$__cc\]\D{%x %X}\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-$__vim\[$__cc\]\$>\[$__nc\]"
export PS2="\[$__cr\]└─\[$__cc\]>\[$__nc\]"

#fix history
export HISTCONTROL=ignoredups             # no duplicate entries
export HISTSIZE=100000                    # big history
export HISTFILESIZE=20000                 # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                       # append to history, not overwrite it
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
#shopt -s dirspell                        # spellcheck for directories(?)

# search-path for CD command
export CDPATH=".:~:~/projects:~/Dropbox/projects"


#
# setup PATH
#

# Bins
PATH=$PATH:/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/sbin
PATH=$PATH:/bin
PATH=$PATH:/usr/games

# put this last, so current dir always gets preference
export PATH=".:$PATH"

