# enable color support of ls and also add handy aliases (ala ubuntu)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#basic aliases
alias ll='ls -oFhA'
alias lm='ls -oFhA | less'
alias cd..='cd ..'
alias more='less'                         # less is more, more or less.
alias py='python '
alias ping='ping -c 10 '                  # set a default, coz I always forget
alias rm='rm -i '                         # confirm, just in case...
alias please='sudo $(fc -ln -1)'          # redo last command as root
alias R='. ~/.bash_profile'

# lil' bit of fun
alias f='fortune -ae'
alias dopewars='dopewars -tn'
alias RR='[ $[ $RANDOM % 6 ] == 0 ] && echo *BANG* || echo *Click*'

#alternative to cd -
alias back='cd $OLDPWD'
alias home='cd ~'
alias up='cd ..'
alias dotfiles='cd ~/dotfiles'
alias paths='echo $PATH | tr ":" "\n" | sort -u'

# grep helpers
alias notes='hgrep \#'
alias csgrep=' grep -Ir --exclude-dir="\.svn" --exclude="*\.css" '
alias sgrep=' grep -Ir --exclude-dir="\.svn" '

# ip/port helper
alias ports="sudo lsof -i -P | grep -i \"listen\"" # list listening ports:
alias iip="ifconfig | grep broadcast | awk '{print $ 2}'" # get internal ip
alias eip="dig +short myip.opendns.com @resolver1.opendns.com" #get external ip

# get weather from wttr.in
alias weather="curl wttr.in/PIT"
alias moon="curl wttr.in/Moon"

# speed up gulp dev
alias ggw="gulp && gulp watch"

# https://roots.io/trellis/ dev servers
alias trellis="cd trellis/ && vagrant up && cd ../"
alias untrellis="cd trellis/ && vagrant halt && cd ../"
alias trellis-ssh="cd trellis/ && vagrant ssh"

# pretty-print git logs
# via https://coderwall.com/p/euwpig
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit  "

# serve dir as static site
alias serve="python -m SimpleHTTPServer"

# prettyprint json
alias ppjson='python -m json.tool'

# from dancingpenguinsoflight
# depends on imagick
alias imginfo="identify -format '-- %f -- \nType: %m\nSize: %b bytes\nResolution: %wpx x %hpx\nColors: %k'"
alias imgres="identify -format '%f: %wpx x %hpx\n'"

case $OSTYPE in
    darwin*)
# osx-only
    alias hosts='sudo mvim -v /etc/hosts /private/etc/hosts'
    alias ss2='screencapture -xP '
    alias ss='screencapture -xwP '
    ;;
esac

# pastebin-like services, pipe to these
alias tb="nc termbin.com 9999"
alias sp="curl -F 'sprunge=<-' http://sprunge.us"
alias cl="clbin=<-' https://clbin.com"
alias vp="curl -F 'text=<-' http://vpaste.net"
alias ix="curl -F 'f:1=<-' ix.io"

