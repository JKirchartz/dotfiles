#! /bin/sh
#
# cowsay.sh
# modified from github.com/msankhala/cowsayfun

if [[ -d '/usr/share/cowsay/cows/' ]]; then
  cowfiledir='/usr/share/cowsay/cows/'
else
  if command -v locate >/dev/null 2 >&1; then
    # automatically detect cowfile dir w/ locate
    cowfiledir=$(locate "*.cow" | rev | cut -d/ -f2- | rev | uniq)
  fi
fi
# #array of cow files
files=( $(find $cowfiledir -maxdepth 1 -type f) )
randomcowfile=${files[RANDOM%${#files[@]}]}
# warning: -a returns all fortunes, offensive or not;
fortune -as | cowsay -f "$randomcowfile"
