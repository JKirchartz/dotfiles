# set readline to be vi-like
set -o vi

#
# source external files
#

source $HOME/dotfiles/bash_aliases

#
# setup prompt
#

function __prompt {
  echo
  # sync history across terms
  history -a
  history -n
  #draw horizontal rule
  printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#'
  DIR=$(pwd | sed -e "s!$HOME!~!")
  echo -e "\n${DIR}"
}
PROMPT_COMMAND="__prompt"
export __cr='\e[0;31m'
export __cc='\e[0;36m'
export __cw='\e[1;37m'
export __nc='\e[0m' #no color
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
export PS1="\[$__cr\]┌─[\[$__cc\]\u@\h\[$__cr\]]-[\[$__cc\]\D{%x %X}\[$__cr\]]-[\[$__cc\]\j\[$__cr\]]\n\[$__cr\]└─[\[$__cc\]\!\[$__cr\]]-$__vim\[$__cc\]\$>\[$__nc\]"
export PS2="\[$__cr\]└─\[$__cc\]>\[$__nc\]"

#fix history
export HISTCONTROL=ignoredups             # no duplicate entries
export HISTSIZE=50000                     # big history
export HISTFILESIZE=50000                 # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                       # append to history, not overwrite it
shopt -s autocd                           # cd automatically when entering a path
shopt -s cdspell                          # spellcheck for cd
shopt -s nocaseglob                       # ignore case for autoexpansion
#shopt -s dirspell                        # spellcheck for directories(?)
shopt -s expand_aliases

# put this last, so current dir & my scripts always get preference
# this is insecure because various bins are overwritten by the current/script
# directory versions, for security move $PATH to the beginning of the assignment
export PATH=".:$HOME/dotfiles/scripts:$PATH"
