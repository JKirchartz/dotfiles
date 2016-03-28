#! /bin/sh
#
# gitstatus.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


OLDIFS=$IFS
IFS=$'\n'
gitstatus=`git status -sb --porcelain`
branch=$(echo "$gitstatus" | head -1 | cut -c4- | cut -d'.' -f1 )
uptodate=""
if echo "$gitstatus" | grep '\.\.\.' &> /dev/null; then
  uptodate="="
fi
if echo "$gitstatus" | grep '^M' &> /dev/null; then
  staged=true
fi
unstaged=false
if echo "$gitstatus" | grep '^ M' &> /dev/null; then
  unstaged=true
fi
untracked=false
if echo "$gitstatus" | grep '^??' &> /dev/null; then
  untracked=true
fi
modified=""
if $staged || $unstaged || $untracked; then
  modified="*"
  if $staged; then
    modified="*+"
  fi
fi

deleted=""
if echo "$gitstatus" | grep '^ A' &> /dev/null; then
  deleted="-"
fi


echo "(${branch} ${modified}${uptodate})"
IFS=$OLDIFS

