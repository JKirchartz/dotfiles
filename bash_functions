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


# easy start grunt projects
begin () {
	if [ -n "$TMUX" ]; then
		tmux split-window -v -p 90 "grunt server" 'C-m';
	else
		grunt server;
	fi
}


# test if the internet is back on
waitforinternet () {
	iptoping=8.8.8.8
		if ["$1" -neq ""]; then
			iptoping=$1;
	fi
		while true; do
			ping -c1 $iptoping 1>/dev/null 2>&1;
	if [ $? -eq 0 ]; then
		say "Now we're cookin!";
	ping -c1 $iptoping;
	break
	else:
		sleep 10;
	fi
		done
}
