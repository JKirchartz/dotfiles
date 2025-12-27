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
        $XDG_BIN_HOME/fortune.sh | $XDG_BIN_HOME/cowsay.sh | lolcat
      else
        $XDG_BIN_HOME/fortune.sh | $XDG_BIN_HOME/cowsay.sh
      fi
    else
      $XDG_BIN_HOME/fortune.sh
    fi
  else
    if which cowsay > /dev/null; then
      $XDG_BIN_HOME/ObliqueStrategies | $XDG_BIN_HOME/cowsay.sh
    else
      $XDG_BIN_HOME/ObliqueStrategies
    fi
  fi
else
  if which fortune > /dev/null; then
    $XDG_BIN_HOME/fortune.sh -s
  else
    $XDG_BIN_HOME/ObliqueStrategies
  fi
fi

