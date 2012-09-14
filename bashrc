set -o vi
PS1="\$\w>"

#fix history
export HISTCONTROL=ignoredups
export HISTSIZE=10000 HISTFILESIZE=10000
export HISTIGNORE="&:ls:ll:pwd:exit:clear"
shopt -s histappend

#basic aliases
alias ll='ls -ahlFG'
alias grep='grep --color=auto'
alias pg='ps -ef | grep'
alias cd..='cd ..'
alias more='less'
#alternative to cd -
alias back='cd $OLDPWD' 


# physically print code nicely to the default printer
alias codeprint='enscript --line-number --pretty-print --fancy-header --landscape '

# pretty-print git logs
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


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
    echo -e '---\nlayout: post\ntitle: '$TITLE'\npublished: false\n---\n' > $(date '+%Y-%m-%d-')"$FILE"'.md'
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

##
# Your previous /Users/jkirchartz/.bash_profile file was backed up as /Users/jkirchartz/.bash_profile.macports-saved_2012-09-05_at_18:43:43
##

# MacPorts Installer addition on 2012-09-05_at_18:43:43: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

