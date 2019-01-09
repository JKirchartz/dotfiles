#! /bin/sh
#
# shell_test.sh
#
# Copyleft (ↄ) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


function parser {
  shopt -s nocasematch
  case "$*" in
    exit) exit 0;;
    echo*) shift; echo $*;;
    *) figlet $* | lolcat;;
  esac
}

# fake a shell
while read -p "$>" i; do parser $i; done
