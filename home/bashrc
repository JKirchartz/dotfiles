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

. "${XDG_CONFIG_HOME:-$HOME/.config}/locale.conf"
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions"
. "${XDG_CONFIG_HOME:-$HOME/.config}/shell/gitstatus.sh"

if command -v fzf >/dev/null 2>&1; then
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && . "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
  eval "$(fzf --bash)"
fi

if command -v grunt >/dev/null 2>&1; then eval "$(grunt --completion=bash)"; fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

#}}}-----------------------------
# setup prompt
#------------------------------{{{

# OS_RELEASE=$(grep -oP '^NAME="\K[^ "]+' /etc/os-release)
# setup our color scheme...
_cr='\e[0;31m' # color red
_cc='\e[0;36m' # color cyan
_cw='\e[1;37m' # color white
_nc='\e[0m'    # no color
# reuse the colors, but in the format the prompt expects
__cr="\[$_cr\]" # color red
__cc="\[$_cc\]" # color cyan
__cw="\[$_cw\]" # color white
__nc="\[$_nc\]"   # no color

# draw horizontal rule with the directory name & git status in it
__drawHR() {
  # printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '=' # ASCII-only
  # printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | sed 's/ /═/g' # Unicode
  ## use ddate if available
  if command -v ddate > /dev/null 2>&1
  then
    dd=$(ddate  +"%d/%B/%Y %N(%H)")
    dt=$(date +"%T %p")
    __dtstamp="$dd $dt"
  else
  ## otherwise show "Gregorian" date
    __dtstamp='\D{%x %X}'
  fi
  # Get directory (and git-prompt)
  DIR=$(pwd | sed -e "s!$HOME!~!")
  PRE="${DIR} $(gitstatus)"
  PRE=$(echo "$PRE" | xargs) # trim whitespace
  WID="${COLUMNS:-$(tput cols)}" # get column count from the term, or tputs
  # 7 = magic number of characters NOT to include in the HR width
  # (by counting how many characters the unicode adds, or trial & error)
  # PREWID=$(((${#PRE} + ${#OS_RELEASE} + ${#__dtstamp} + 12) % WID))
  PREWID=$(((${#PRE} + ${#__dtstamp} + 7) % WID))
  printf '\e[0;31m╔═╡\e[m\e[0;36m%s\e[0;31m╞' "$PRE"
  # instead of filling a column with spaces then replacing the spaces,
  # let's draw directly counting from PREWID+1 to the full width
  printf '\e[0;31m%.0s═\e[m' $(seq $((PREWID + 1)) "${WID}")
  printf '\e[0;31m═╡\e[m \e[0;36m%s' "$__dtstamp"
  # printf '\e[0;31m ╞═╡\e[m \e[0;36m%s\n' "$OS_RELEASE"
  echo -e '\n\e[0;31m║\e[m'
}

__prompt() {
  echo
  # sync history across terms
  history -a
  history -n
  __drawHR;
  # construct the same prompt as below, but more intelligently
  PS1="$__cr╚╡$__cc"
  [ -n "$(jobs -p)" ] && PS1+="$__cr($__cc\j$__cr)$__cc"
  [ -z "$STY$TMUX" ] && PS1+="\u@\h"
  [ -e "${VIMRUNTIME}" ] && PS1+="${__cr}(${__cc}vim${__cr})${__nc}"
  PS1+="$__cc\$▸ $__nc"
  export PS1
}

PROMPT_COMMAND="__prompt"

# set prompt
# export PS0="$__cr╠╡$__nc" # returns before the output of a command
export PS1="$__cr╚╡$__cc\u@\h$__cr$__cc\$$__cc▸ $__nc"
export PS2="$__cc▸ $__nc"

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
export HISTIGNORE="ls:ll:pwd:exit:clear:reset"
shopt -s histappend                       # append to history, not overwrite it


#}}}-----------------------------
#fix cd
#------------------------------{{{
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
shopt -s expand_aliases
shopt -s autocd                           # cd automatically when entering a path
shopt -s dirspell                         # spellcheck for directories(?)

# search-path for CD command
# export CDPATH=".:..:~:~/projects:~/Dropbox/projects"


if command -V gdircolors &> /dev/null
then
  eval "$(gdircolors -b "$XDG_CONFIG_HOME/dir_colors/LS_COLORS")"
elif command -V dircolors &> /dev/null
then
  eval "$(dircolors -b "$XDG_CONFIG_HOME/dir_colors/LS_COLORS")"
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
# "$STY" could work instead of looking for parent processes
# if shopt -q login_shell && [ -z "$STY" ]; then; tmu; fi
# or tmux?
# if shopt -q login_shell && [ -z "$TMUX" ]; then; tmu; fi

# }}} fold up this file
# vim: foldmethod=marker filetype=bash
