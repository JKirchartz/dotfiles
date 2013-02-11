set -o vi
#PS1="\$\w>"
export PS1="\[$(tput setaf 1)\]\n|---[\[$(tput setaf 6)\]\w\[$(tput setaf 1)\]]-[\[$(tput setaf 6)\]\u@\h\[\[$(tput setaf 1)\]]-[\[$(tput setaf 6)\]\D{%x %X}\[$(tput setaf 1)\]]---\n|[\[$(tput setaf 6)\]\!\[$(tput setaf 1)\]]-\[$(tput setaf 6)\]\$>\[$(tput sgr0)\]"
export PS2="\[$(tput setaf 1)\]|\[$(tput setaf 6)\]>\[$(tput sgr0)\]"

# # TMUX
# if which tmux 2>&1 >/dev/null; then
#    # if no session is started, start a new session
#    test -z ${TMUX} && tmux
#
#    # when quitting tmux, try to attach
#    while test -z ${TMUX}; do
#        tmux attach || break
#    done
# fi

#fix history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000                     # big history
export HISTFILESIZE=100000               # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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
#alternative to cd -
alias back='cd $OLDPWD'
alias home='cd ~'
alias dotfiles='cd ~/dotfiles'

# what date is this month's buildguild?
alias buildguild="ncal | grep We | awk '{print $ 3}'"

# physically print code nicely to the default printer
alias codeprint='enscript --line-number --pretty-print --fancy-header --landscape '

# pretty-print git logs
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# gh-pages jekyll generation
alias ghp="jekyll --pygments --no-lsi --safe"

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

# send a note to myself with futz.me
function futz () {
    if [ -z "$1" ]
    then
        read -p "Futz what?" MSG 
    else 
        MSG="$1"
    fi
    #replace with your username, please don't spam me!
    curl -Ls futz.me/jkirchartz%20$(echo $MSG | tr ' ' + ) > /dev/null
}

# easier jekyll post
function new_post () {
    if [ -z "$1" ]
    then
        read -p "Post Title:"  TITLE
    else
        TITLE="$1"
    fi
    FILE=$( echo $TITLE | tr A-Z a-z | tr ' ' _ )
    echo -e '---\nlayout: post\ntitle: '$TITLE'\npublished: false\ntags:\n---\n' > $(date '+%Y-%m-%d-')"$FILE"'.md'
}

# easier git commit & push
function gcp () {
    if [ -z "$1" ]
    then
        read -p "Commit Message:" MSG
    else
        MSG="$1"
    fi
    git add .
    git commit -am "$MSG"
    git push
}

PATH="~/gems/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

export GEM_HOME=~/gems
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# MacPorts Installer: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

