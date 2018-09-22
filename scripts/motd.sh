#! /bin/sh
#
# motd.sh
#
# Copyleft (ↄ) 2016 kirch <kirch@arp>
#
# Distributed under terms of the NPL license.
#

date +"Good %H, $USER" | sed -e 's/0[5-9]\|1[01]/Morning/' -e 's/1[2-8]/Afternoon/' -e 's/[0-9]\+/Evening/'

if [ -z "${VIMRUNTIME}" ]; then
  if which fortune > /dev/null; then
    if which cowsay > /dev/null; then
      ~/dotfiles/scripts/fortune.sh | ~/dotfiles/scripts/cowsay.sh
    else
      ~/dotfiles/scripts/fortune.sh
    fi
  else
    if which cowsay > /dev/null; then
      ~/dotfiles/scripts/ObliqueStrategies | ~/dotfiles/scripts/cowsay.sh
    else
      ~/dotfiles/scripts/ObliqueStrategies
    fi
  fi
else
  if which fortune > /dev/null; then
    ~/dotfiles/scripts/fortune.sh -s
  else
    ~/dotfiles/scripts/ObliqueStrategies
  fi
fi

