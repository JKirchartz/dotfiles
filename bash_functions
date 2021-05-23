# Function to update a shell inside tmux with new environment variables (really
# useful for switching between ssh and local) function update-environment
# stolen from https://github.com/xanderman/dotfiles/blob/master/.bashrc#L105
function update-environment () {
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
psgrep(){ ps -ax | grep "$1" | grep -v "grep"; }
# why not history
function hgrep(){
  grep "$@" "${HISTFILE}"
}

#simple calculator
calc () { echo "$*" | bc -l; }

# tmux title changer
tmut () {
  if [[ $# -eq 0 ]]; then
    # rename tmux window after current directory
    tmux rename-window "${PWD##*/}";
  else
    # rename tmux window after input
    tmux rename-window "$@";
  fi
}

# tmux split and run
tmus () { tmux split-window -p 20 $@; }

# mk & cd
mkcd() { mkdir "$@" && cd "$@"; }

# open files specified by other utilities
gitvim () { vim $(git diff --name-only $@ ); }
ackvim () { vim $(ack -l $@ ); }
rgvim () { vim $(command rg -l $@ ); }

cwd () {
  if [ $# -eq 0 ]; then
    echo "Enter a word pattern to search for, use a . for unknowns";
  fi
  grep -w -i $1 /usr/share/dict/words;
}

fixssh () {
  ssh-add -K;
  eval $(ssh-agent);
  ssh-add -K;
}

rg () {
  command rg -p $@ | less -MRFX;
  # TODO: investigate less -rFiXSw
}

lsd () {
  ls $@ | lolcat
}
