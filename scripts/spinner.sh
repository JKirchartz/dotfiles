#! /bin/sh
#
# spinner.sh
# Copyright (C) 2015 jkirchartz <jkirchartz@jkirchartz-glaptop>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

spinstr='|/-\'
tput civis
tput clear
while [ true ]; do
  temp=${spinstr#?}
  printf "\r%c" "$spinstr"
  spinstr=$temp${spinstr%"$temp"}
  sleep 0.2
done
printf "\r"
tput clear
tput cnorm
