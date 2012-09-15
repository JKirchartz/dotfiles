set -o vi
#PS1="\$\w>"
export PS1="\[$(tput setaf 1)\]\n---[\[$(tput setaf 6)\]\u@\h\[$(tput setaf 1)\]]--[\[$(tput setaf 6)\]\w\[\[$(tput setaf 1)\]]--[\[$(tput setaf 6)\]\t\[$(tput setaf 1)\]]---\n-[\[$(tput setaf 6)\]\!\[$(tput setaf 1)\]]-\[$(tput setaf 6)\]\$>\[$(tput sgr0)\]"
export PS2="\[$(tput setaf 6)\]>\[$(tput sgr0)\]"

#fix history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000                     # big history
export HISTFILESIZE=100000               # big history
export HISTIGNORE="&:ls:ll:pwd:exit:clear:[ \t]*"
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


#basic aliases
alias ll='ls -ahlFG'
alias grep='grep --color=auto'
alias pg='ps -ef | grep'
alias cd..='cd ..'
alias more='less' #less is more, more or less.
#alternative to cd -
alias back='cd $OLDPWD' 


# physically print code nicely to the default printer
alias codeprint='enscript --line-number --pretty-print --fancy-header --landscape '

# pretty-print git logs
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

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

