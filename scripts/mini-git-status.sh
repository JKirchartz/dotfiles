#! /bin/sh
#
# mini-git-status.sh
# Copyleft 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


stats=`git status --porcelain`

if echo $stats | grep -q ^M; then
  echo 'modified'
fi

if echo $stats | grep -q ^A; then
  echo 'added'
fi

if echo $stats | grep -q ^D; then
  echo 'deleted'
fi

if echo $stats | grep -q ^R; then
  echo 'renamed'
fi

if echo $stats | grep -q ^C; then
  echo 'copied'
fi

if echo $stats | grep -q ^U; then
  echo 'updated'
fi

if echo $stats | grep -q ^?; then
  echo 'untracked'
fi

if echo $stats | grep -q ^!; then
  echo 'ignored'
fi
