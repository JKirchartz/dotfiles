# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# avoid shellcheck errors for sourced files?
# shellcheck source=/dev/null

#}}}-----------------------------
# set readline to be vi-like
#------------------------------{{{

set -o vi

#}}}-----------------------------
# source external files
# fzf, git, npm, bashisms
#------------------------------{{{

source "${XDG_CONFIG_HOME:-$HOME/.config}/locale.conf"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/gitstatus.sh"

if command -v fzf >/dev/null 2>&1; then
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
  eval "$(fzf --bash)"
fi

if command -v grunt >/dev/null 2>&1; then eval "$(grunt --completion=bash)"; fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

#}}}-----------------------------
# setup prompt
#------------------------------{{{

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
if [ -f "$HOME/.bash_history" ]; then
	export HISTFILE="${HOME}/.bash_history"
else
	export HISTFILE="${XDG_STATE_HOME}/bash/history"
fi
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


if command -V gdircolors &> /dev/null
then
  eval "$(gdircolors -b "$XDG_CONFIG_HOME/dircolors/LS_COLORS")"
elif command -V dircolors &> /dev/null
then
  eval "$(dircolors -b "$XDG_CONFIG_HOME/dircolors/LS_COLORS")"
fi

#}}}-----------------------------
# paths and completions
#------------------------------{{{


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change. (?)
# export PATH="$PATH:$HOME/.local/share/gem/ruby/3.1.0/bin:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# motd
~/dotfiles/bin/motd.sh

# autostart screen on login?
# if shopt -q login_shell && [ "$(ps -p $PPID -o comm=)" != screen ]; then scr; fi
# or tmux?
# if shopt -q login_shell && [ -z "$TMUX" ]; then; tmu; fi

# }}} fold up this file
# vim: foldmethod=marker
