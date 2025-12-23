#! /bin/sh
#
# motd.sh
#
# Copyleft (ↄ) 2016 kirch <kirch@arp>
#
# Distributed under terms of the NPL license.
#

if [ -z "${VIMRUNTIME}" ]; then
  if which fortune > /dev/null; then
    if which cowsay > /dev/null; then
      if which lolcat > /dev/null; then
        ~/dotfiles/bin/fortune.sh | ~/dotfiles/bin/cowsay.sh | lolcat
      else
        ~/dotfiles/bin/fortune.sh | ~/dotfiles/bin/cowsay.sh
      fi
    else
      ~/dotfiles/bin/fortune.sh
    fi
  else
    if which cowsay > /dev/null; then
      ~/dotfiles/bin/ObliqueStrategies | ~/dotfiles/bin/cowsay.sh
    else
      ~/dotfiles/bin/ObliqueStrategies
    fi
  fi
else
  if which fortune > /dev/null; then
    ~/dotfiles/bin/fortune.sh -s
  else
    ~/dotfiles/bin/ObliqueStrategies
  fi
fi

