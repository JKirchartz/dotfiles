#! /bin/bash
#
# cowsay.sh
# was modified from github.com/msankhala/cowsayfun, until I found a different 
# way

if type shuf > /dev/null; then
  cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
else
  cowfiles=( $(cowsay -l | sed "1 d" | tr ' ' '\n') );
  cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
fortune -as | cowsay -f "$cowfile"

# fortune -as | cowsay -f "$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
