#! /bin/sh
#
# words.sh
# Copyright (C) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

function rword() {
  if type shuf > /dev/null; then
    shuf -n1 /usr/share/dict/words
  else
    cat /usr/share/dict/words | grep -v "'" | sort -R | head -n 1
  fi
}

while [[ true ]]; do
  echo "$(rword)" | cowsay.sh
  sleep 10
  clear
done
