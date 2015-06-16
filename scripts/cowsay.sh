#! /bin/sh
#
# cowsay.sh
# modified from github.com/msankhala/cowsayfun

if [[ command -v locate 2>/dev/null ]]; then
  # automatically detect cowfile dir w/ locate
  cowfiledir=$(locate "*.cow" | rev | cut -d/ -f2- | rev | uniq)
else
  cowfiledir='/usr/share/cowsay/cows/'
fi
# #array of cow files
files=$(find $cowfiledir -maxdepth 1 -type f)
randomcowfile=${files[RANDOM%${#files[@]}]}
# warning: -a returns all fortunes, offensive or not;
fortune -as | cowsay -f $randomcowfile

