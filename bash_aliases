#basic aliases
alias ll='ls -ahlFG'
alias lm='ls -ahlFG | more'
alias cd..='cd ..'
alias more='less'                         # less is more, more or less.
alias py='python '
alias ping='ping -c 10 '                   # set a default, coz I always forget
alias rm='rm -i '                          # confirm, just in case...
alias sudo='sudo '                        # check for aliases AFTER sudo
alias please='sudo !! '
alias f='fortune -as'
alias ss='screencapture -xP '
alias R='. ~/.bash_profile'
alias RR='[ $[ $RANDOM % 6 ] == 0 ] && echo *BANG* || echo *Click*'
#alternative to cd -
alias back='cd $OLDPWD'
alias home='cd ~ '
alias dotfiles='cd ~/dotfiles'
#script shortcuts
alias new_post="~/dotfiles/scripts/new_post.sh"
alias publish="~/dotfiles/scripts/publish.sh"
alias sizetmux="~/dotfiles/scripts/sizetmux.sh"
alias futz="~/dotfiles/scripts/futz.sh"
alias gcpp="~/dotfiles/scripts/gcpp.sh"
alias gcp="~/dotfiles/scripts/gcp.sh"
alias pipes="~/dotfiles/scripts/pipes.sh"

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
