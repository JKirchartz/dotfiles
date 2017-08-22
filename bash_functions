# Function to update a shell inside tmux with new environment variables (really
# useful for switching between ssh and local) function update-environment
# stolen from https://github.com/xanderman/dotfiles/blob/master/.bashrc#L105
function update-environment {
  local v
  while read v; do
    if [[ $v == -* ]]; then
      unset "${v/#-/}"
    else
      # Surround value with quotes
      v=${v/=/=\"}
      v=${v/%/\"}
      eval export "$v"
    fi
  done < <(tmux show-environment)
}

# ps + grep, incase there's no pgrep(?)
function psgrep(){ ps -ax | grep "$1" | grep -v "grep"; }
# why not history
function hgrep(){ history | grep "$1"; }

#simple calculator
function calc () { echo "$*" | bc -l; }

#tmux title changer
function tmut () {
  if [[ $# -eq 0 ]]; then
    # rename tmux window after current directory
    tmux rename-window "${PWD##*/}"
  else
    # rename tmux window after input
    tmux rename-window "$@"
  fi
}

# cd & ls
function cl() { cd "$@" && ls -oFhA; }

# open files specified by other utilities
function gitvim () { vim $(git diff --name-only $@ ); }
function ackvim () { vim $(ack -l $@ ); }

# easy unzip
function extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"      ;;
            *.tar.gz)   tar xzf "$1"      ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      rar x "$1"        ;;
            *.gz)       gunzip "$1"       ;;
            *.tar)      tar xf "$1"       ;;
            *.tbz2)     tar xjf "$1"      ;;
            *.tgz)      tar xzf "$1"      ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
     else
        echo "'$1' is not a valid file"
     fi
}


clbin () {
    if [ "$*" ]; then
        local prompt="$(PS1="$PS1" bash -i <<<$'\nexit' 2>&1 | head -n1)"
        ( echo "$(sed 's/\o033\[[0-9]*;[0-9]*m//g'  <<<"$prompt")$@"; exec $@; )
    else
        cat
    fi | curl -F 'clbin=<-' http://clbin.com
}

sprunge () {
    if [ "$*" ]; then
        local prompt="$(PS1="$PS1" bash -i <<<$'\nexit' 2>&1 | head -n1)"
        ( echo "$(sed 's/\o033\[[0-9]*;[0-9]*m//g'  <<<"$prompt")$@"; exec $@; )
    else
        cat
    fi | curl -F 'sprunge=<-' http://sprunge.us
}
transfer() {
        if [ $# -eq 0 ]; then
                echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
        fi;
        tmpfile=$( mktemp -t transferXXX );
        if tty -s; then
                basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
                curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
        else
                curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile;
        fi;
        cat $tmpfile;
        rm -f $tmpfile;
}



# easy start trellis projects
tbegin () {
        cd "$1" || exit 1;
        cd "trellis" || exit 1;
        vagrant up
        cd "../theme" || exit 1;
        if [ -n "$TMUX" ]; then
                tmux split-window -v -p 90 "gulp && gulp watch" 'C-m'
        else
                gulp && gulp watch
        fi
}


# test if the internet is back on
waitforinternet () {
    iptoping=8.8.8.8
    if ["$1" -neq ""]; then
        iptoping=$1
    fi
    while true; do
        ping -c1 $iptoping 1>/dev/null 2>&1
        if [ $? -eq 0 ]; then
                say "Now we're cookin!"
                ping -c1 $iptoping
                break
        else:
                sleep 10
        fi
   done
}
