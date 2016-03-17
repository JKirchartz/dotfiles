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
function tmut () {  printf "\033k%s\033\\" "$1"; }

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

