#! /bin/bash
#
# cowsay.sh
#

eyes=("oo" "oo" "oo" "oo" "oo" "oo" "oo" "oo" "oo" "oo" "xx" "xX" "Xx" "**" "66" "99" "\=\=" "\@\@" "\?\?" "\$\$" "ee" "oO" "Oo" "o0" "0o" "00" "OO" "\-\-")
eye=${eyes[$(($RANDOM % ${#eyes[*]}))]}


# WIDTH=($(tput cols) - 50) # I never quite got this to look good (-W flag on cowsay)
if type shuf >/dev/null 2>&1; then
  cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
else
  cowfiles=( $(cowsay -l | sed "1 d") );
  cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi

think=$(($RANDOM % 4))
if [ $think -eq 1 ]; then
  cowthink -e "$eye" -f "$cowfile" "$@"
else
  cowsay -e "$eye" -f "$cowfile" "$@"
fi

# fortune -as | cowsay -f "$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
