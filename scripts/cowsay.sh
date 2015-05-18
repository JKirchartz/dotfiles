#! /bin/sh
#
# cowsay.sh
# modified from github.com/msankhala/cowsayfun

# automatically detect cowfile dir
cowfiledir=( $(locate "*.cow" | rev | cut -d/ -f2- | rev | uniq))
# #array of cow files
files=( $(find $cowfiledir -maxdepth 1 -type f) )
randomfileindex=$((RANDOM%${#files[@]}+0))
randomcowfile=${files[$randomfileindex]}
# warning: -a returns all fortunes, offensive or not;
fortune -as | cowsay -f $randomcowfile

