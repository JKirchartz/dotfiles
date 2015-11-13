#basic aliases
alias ll='ls -oFhA'
alias lm='ls -oFhA | less'
alias cd..='cd ..'
alias more='less'                         # less is more, more or less.
alias py='python '
alias ping='ping -c 10 '                  # set a default, coz I always forget
alias rm='rm -i '                         # confirm, just in case...
alias sudo='sudo '                        # check for aliases AFTER sudo(?)
alias please='sudo !! '
alias f='fortune -ae'
alias R='. ~/.bash_profile'
alias RR='[ $[ $RANDOM % 6 ] == 0 ] && echo *BANG* || echo *Click*'
#alternative to cd -
alias back='cd $OLDPWD'
alias home='cd ~'
alias up='cd ..'
alias dotfiles='cd ~/dotfiles'

# grep helpers
alias notes='hgrep \#'
alias csgrep=' grep -Ir --exclude-dir="\.svn" --exclude="*\.css" '
alias sgrep=' grep -Ir --exclude-dir="\.svn" '
alias ports="sudo lsof -i -P | grep -i \"listen\"" # list listening ports:
alias iip="ifconfig | grep broadcast | awk '{print $ 2}'" # get internal ip
alias eip="dig +short myip.opendns.com @resolver1.opendns.com" #get external ip

# what date is this month's buildguild?
alias buildguild="ncal | grep We | awk '{print $ 3}'"

# pretty-print git logs
# via https://coderwall.com/p/euwpig
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit  "

# gh-pages jekyll generation
alias ghp="jekyll --pygments --no-lsi --safe"
alias ghps="jekyll --pygments --no-lsi --safe --auto --serve"

# serve dir as static site
alias serve="python -m SimpleHTTPServer"

# from dancingpenguinsoflight
# depends on imagick
alias imginfo="identify -format '-- %f -- \nType: %m\nSize: %b bytes\nResolution: %wpx x %hpx\nColors: %k'"
alias imgres="identify -format '%f: %wpx x %hpx\n'"

case $OSTYPE in
    darwin*)
# osx-only
    alias ss2='screencapture -xP '
    alias ss='screencapture -xwP '
    ;;
esac
