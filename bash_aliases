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
alias M='motd.sh'


if test -n "$ZSH_VERSION"; then
	alias R='source ~/.zshrc'
elif test -n "$BASH_VERSION"; then
	alias R='. ~/.bash_profile'
fi



#vim-like aliases
alias :e='vim'
alias :q='exit'
alias :wq='exit'

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


# ip/port helper
alias ports="sudo lsof -i -P | grep -i \"listen\"" # list listening ports:
alias iip="ifconfig | grep broadcast | awk '{print $ 2}'" # get internal ip
alias eip="dig +short myip.opendns.com @resolver1.opendns.com" #get external ip

# get weather from wttr.in
alias weather="curl wttr.in/Pittsburgh"
alias moon="curl wttr.in/Moon"

# speed up gulp dev
alias ggw="gulp && gulp watch"

# speed up grunt dev
alias gs="grunt server"
alias ggd="grunt && grunt deploy"

# https://roots.io/trellis/ dev servers
alias trellis="cd trellis/ && vagrant up && cd ../"
alias untrellis="cd trellis/ && vagrant halt && cd ../"
alias trellis-ssh="cd trellis/ && vagrant ssh"

# capistrano
alias cap2="cap _2.15.4_"
alias cap3="cap _3.0.0_"
alias cap32="cap _3.2.1_"

# pretty-print git logs
# via https://coderwall.com/p/euwpig
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit  "

# serve dir as static site
alias serve="python -m SimpleHTTPServer"
alias serveo="ssh -R 80:localhost:8000 serveo.net"

# prettyprint json
alias ppjson='python -m json.tool'

# from dancingpenguinsoflight
# depends on imagick
alias imginfo="identify -format '-- %f -- \nType: %m\nSize: %b bytes\nResolution: %wpx x %hpx\nColors: %k'"
alias imgres="identify -format '%f: %wpx x %hpx\n'"

case $OSTYPE in
    darwin*)
# osx-only
    alias hosts='sudo vim -v /etc/hosts /private/etc/hosts'
    alias ss2='screencapture -xP '
    alias ss='screencapture -xwP '
    ;;
esac

alias notes='history | grep \#'

# pastebin-like services, pipe to these
alias tb="nc termbin.com 9999"
alias sp="curl -F 'sprunge=<-' http://sprunge.us"
alias cl="clbin=<-' https://clbin.com"
alias vp="curl -F 'text=<-' http://vpaste.net"
alias ix="curl -F 'f:1=<-' ix.io"

alias yt2mp3='youtube-dl --extract-audio --audio-format mp3 '

alias imgsize='identify -format "width: %[w]px;\nheight: %[h]px;"'
alias imgcolor='convert -unique-colors -depth 8 txt:-'

# Docker

alias dockerstopall='docker stop $(docker ps -a -q)'
alias dockerremoveall='docker rm $(docker ps -a -q)'

# the following is weirdness GuyNoIR AKA Bob_Dobbs
# Put these in .bash_aliases
# Speech > Text > Chinese > Russian > English > Speech

# Issues
# Need to pkill pocketsphinx when done because we unbuffer it and shove it into the background

# Ubuntu 17.10
# deps in default repos
# expect pocketsphinx pocketsphinx-en-us

# deps not in default repos
# https://github.com/andreineculau/google-translate-cli


alias SpeakToTheSphinx="touch SphinxPipe; unbuffer pocketsphinx_continuous -inmic yes -logfn /dev/null >> SphinxPipe & tail -f SphinxPipe | grep --line-buffered -vwE 'READY....|Listening...' | stdbuf -oL trans -b {en=zh-CN} | stdbuf -oL trans -b {zh-CN=ru} | stdbuf -oL trans -b -p {ru=en}"

alias KillTheSphinx="sudo pkill -9 pocketsphinx; reset; echo ''; rm SphinxPipe; echo ''; ps aux | grep pocketsphinx; echo ''"



