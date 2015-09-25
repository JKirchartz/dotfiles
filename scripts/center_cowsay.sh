#! /bin/bash
#
# center_cowsay.sh
# cowsay centered in the terminal (probably more convaluted than it needs to be)
# Copyright (C) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

# get terminal width
if type tput > /dev/null; then
  termwidth=$(tput cols)
else
  termwidth=`stty size | cut -d" " -f2`
fi
# get random cowfile
if type shuf > /dev/null; then
  cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
else
  cowfiles=( $(cowsay -l | sed "1 d") );
  cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
cowwidth=`echo "" | cowsay -f "$cowfile" | wc -L`
cowspaces=`printf "%*s" $((($termwidth-$cowwidth)/2))`

# pad cowsay
cowsay -f "$cowfile" -W $cowwidth | sed -e "s/^/$cowspaces/"
