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
function hgrep(){
	grep "$@" "${HISTFILE}"
}

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

# mk & cd
function mkcd() { mkdir "$@" && cd "$@" }

# open files specified by other utilities
function gitvim () { vim $(git diff --name-only $@ ); }
function ackvim () { vim $(ack -l $@ ); }


# easy start grunt projects
gruntbegin () {
	if [ -n "$TMUX" ]; then
		tmux split-window -v -p 90 "grunt server" 'C-m';
	else
		grunt server;
	fi
}

cwd () {
  if [ $# -eq 0 ]; then
    echo "Enter a word pattern to search for, use a . for unknowns"
  fi
  grep -w -i $1 /usr/share/dict/words
}


function fix-ssh {
  ssh-add -K;
  eval $(ssh-agent);
  ssh-add -K;
}


function rg () {
  # use rg as function name:
  command rg -p $@ | less -MrFX
  # don't use rg as function name:
  # rg -p $@ | less -MRFX
  # TODO: investigate less -rFiXSw
}

