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

