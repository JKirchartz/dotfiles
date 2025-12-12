#! /bin/bash

LABEL=`uname -a`

case $LABEL in
  *arch*) sudo pacman -S git vim tmux fortune-mod cowsay;;
  *debian*|*ubuntu*) sudo apt-get install git vim tmux fortune cowsay;;
  *darwin*) brew install git vim tmux fortune cowsay;;
esac
