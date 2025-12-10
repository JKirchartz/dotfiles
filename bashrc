# avoid shellcheck errors for sourced files:
# shellcheck source=/dev/null
#}}}-----------------------------
# set readline to be vi-like
#------------------------------{{{
set -o vi

#}}}-----------------------------
# UTF-8
#------------------------------{{{

LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

#}}}-----------------------------
# source external files
# fzf, git, npm, bashisms
#------------------------------{{{

source ~/dotfiles/bash_aliases
source ~/dotfiles/bash_functions

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if command -v grunt >/dev/null 2>&1; then eval "$(grunt --completion=bash)"; fi

#}}}-----------------------------
# setup prompt
#------------------------------{{{

source ~/dotfiles/bin/gitstatus.sh

set__dtstamp() {
  ## use ddate if available
  if command -v ddate > /dev/null 2>&1
  then
    export __dtstamp='$(ddate  +"%d/%B/%Y %N(%H)") $(date +"%T %p")'
  else
    export __dtstamp='\D{%x %X}'
  fi
}

set__dtstamp;

__prompt() {
  echo
  # sync history across terms
  history -a
  history -n
  #draw horizontal rule
  printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#'
  # Get directory (and git-prompt)
  DIR=$(pwd | sed -e "s!$HOME!~!")
  echo -e "\n${DIR} $(gitstatus)"
  # last=$(history | tail -n 1 | rev | cut -d ' ' -f 2 | rev)
  # if [ "$last" = "cd" ]
  # then
  #   echo $(pwd) >> ~/.bash_cdhistory
  # fi
  set__dtstamp;
}

PROMPT_COMMAND="__prompt"
export __cr='\e[0;31m'
export __cc='\e[0;36m'
export __cw='\e[1;37m'
export __nc='\e[0m' #no color
# if shell's running INSIDE vim, mark it with a white V
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
export PS1="\[$__cr\]┌─[\[$__cc\]\u@\h\[$__cr\]]-[\[$__cc\]$__dtstamp\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-$__vim\[$__cc\]\$>\[$__nc\]"
export PS2="\[$__cr\]└─\[$__cc\]>\[$__nc\]"

#}}}-----------------------------
#fix history
#------------------------------{{{
export HISTCONTROL=ignoreboth             # no duplicate entries or entries that start with whitespace
export HISTSIZE=50000                     # big history
export HISTFILESIZE=50000                 # big history
export HISTIGNORE="ls:ll:pwd:exit:clear"
shopt -s histappend                       # append to history, not overwrite it


#}}}-----------------------------
#fix cd
#------------------------------{{{
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
shopt -s expand_aliases
if [ "${BASH_VERSINFO}" -ge 4 ]; then
        # these are new features in bash 4
        shopt -s autocd                   # cd automatically when entering a path
        shopt -s dirspell                 # spellcheck for directories(?)
fi

# search-path for CD command
# export CDPATH=".:..:~:~/projects:~/Dropbox/projects"

#}}}-----------------------------
# paths and completions
#------------------------------{{{

# put this last, so current dir & my scripts always get preference
# this is insecure because various bins are overwritten by my script
# directory versions, for security move $PATH to the beginning of the assignment
export PATH="$HOME/dotfiles/bin:$PATH"

export NETHACKOPTIONS=color,hilite_pet,boulder:8

if [ -n "$TMUX" ]; then
  # wrap SSH so tmux shows the hostname
  ssh () {
    og_name=$(tmux display-message -p '#W');
    tmux rename-window "$1";
    command ssh "$@";
    tmux rename-window "$og_name";
  }
fi


if command -V gdircolors &> /dev/null
then
  eval "$(gdircolors -b "$HOME/dotfiles/LS_COLORS/LS_COLORS")"
else
  eval "$(dircolors -b "$HOME/dotfiles/LS_COLORS/LS_COLORS")"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.1.0/bin:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# all the stuff for if this is WSL
if [ -n "$WSL_DISTRO_NAME}" ]; then
        alias open="/mnt/c/Windows/explorer.exe"
        alias pbcopy="$HOME/dotfiles/bin/wsl-pbcopy.sh"
        alias pbpaste="$HOME/dotfiles/bin/wsl-pbpaste.sh"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#
# }}} fold up this file
# vim: foldmethod=marker
