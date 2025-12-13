#! /bin/sh
#
# motd_screensaver.sh
# Copyright (C) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

function rword() {
  if type shuf > /dev/null; then
    cat /usr/share/dict/words | grep -v "'" | shuf -n1
  else
    cat /usr/share/dict/words | grep -v "'" | sort -R | head -n 1
  fi
}

while [[ true ]]; do
  clear
  fortune.sh | center_cowsay.sh
  echo "Word of the moment is: $(rword)"
  sleep 30s
done
