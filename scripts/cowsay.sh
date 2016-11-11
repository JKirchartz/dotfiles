#! /bin/bash
#
# cowsay.sh
#


WIDTH=($(tput cols) - 20)
if type shuf >/dev/null 2>&1; then
  cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
else
  cowfiles=( $(cowsay -l | sed "1 d") );
  cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
cowsay -f "$cowfile" -W $WIDTH "$@"

# fortune -as | cowsay -f "$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
