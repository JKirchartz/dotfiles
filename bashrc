set -o vi
export TERM=xterm

# TMUX
if which tmux 2>&1 >/dev/null; then
   # if no session is started, start a new session
   test -z ${TMUX} && tmux

   # when quitting tmux, try to attach
   while test -z ${TMUX}; do
       tmux attach || break
   done
fi

# login message
if which fortune > /dev/null; then
     if which cowsay > /dev/null; then
        fortune -as | cowsay -f small
     else
        fortune -as
    fi
fi

#define colors
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

function __prompt {
    # Save and reload the history after each command finishes
    history -a
    history -c
    history -r
    # Get directory & generate term-wide hr
    DIR=`pwd|sed -e "s!$HOME!~!"`
    #this depends on the calc function
    cols=`calc $(tput cols) - ${#DIR}`
    echo
    echo -n $DIR
    for ((x = 0; x < cols; x++)); do
        printf %s -
    done
    echo
}
PROMPT_COMMAND="__prompt"
export PS1="\[$COLOR_RED\]$(echo -e "\033(0lqq\033(B")[\[$COLOR_CYAN\]\u@\h\[$COLOR_RED\]]-[\[$COLOR_CYAN\]\D{%x %X}\[$COLOR_RED\]]-[\[$COLOR_CYAN\]\j\[$COLOR_RED\]]\n$(echo -e "\033(0m\033(B")[\[$COLOR_CYAN\]\!\[$COLOR_RED\]]-[\[$COLOR_CYAN\]\$>\[$COLOR_NC\]"
export PS2="\[$COLOR_RED\]$(echo -e "\033(0m\033(B"))\[$COLOR_CYAN\]>\[$COLOR_NC\]"


#fix history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000                     # big history
export HISTFILESIZE=1000                 # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                      # append to history, don't overwrite it


# Grep Colors
export GREP_OPTIONS='--color=auto' GREP_COLOR='00;38;5;157'

#basic aliases
alias ll='ls -ahlFG'
alias lm='ls -ahlFG | more'
alias pg='ps -ef | grep'
alias cd..='cd ..'
alias more='less' #less is more, more or less.
alias py='python'
alias ping='ping -c 10' #set a default, coz I always forget
alias please='sudo !!'
alias f='fortune -as'
#alternative to cd -
alias back='cd $OLDPWD'
alias home='cd ~'
alias dotfiles='cd ~/dotfiles'
#script shortcuts
alias new_post="~/dotfiles/scripts/new_post.sh"
alias futz="~/dotfiles/scripts/futz.sh"
alias gcpp="~/dotfiles/scripts/gcpp.sh"
alias gcp="~/dotfiles/scripts/gcp.sh"

# what date is this month's buildguild?
alias buildguild="ncal | grep We | awk '{print $ 3}'"

# physically print code nicely to the default printer
alias codeprint='enscript --line-number --pretty-print --fancy-header --landscape '

# pretty-print git logs
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# gh-pages jekyll generation
alias ghp="jekyll --pygments --no-lsi --safe"
alias ghps="jekyll --pygments --no-lsi --safe --auto --serve"

# serve dir as static site
alias serve="python -m SimpleHTTPServer"

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

#simple calculator
function calc () { 
    echo "$*" | bc -l; 
}


PATH="~/gems/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

export GEM_HOME=~/gems
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# MacPorts Installer: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#node path
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:$PATH"


