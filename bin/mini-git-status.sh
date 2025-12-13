#! /bin/sh
#
# mini-git-status.sh
# Copyleft 2015 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


gitstats=`git status --porcelain`
gitstatus=''

if echo $gitstats | grep -q ^M; then
  gitstatus="*$gitstatus"
fi

if echo $gitstats | grep -q ^A; then
  gitstatus="+$gitstatus"
fi

if echo $gitstats | grep -q ^D; then
  gitstatus="-$gitstatus"
fi

if echo $gitstats | grep -q ^R; then
  gitstatus="@$gitstatus"
fi

if echo $gitstats | grep -q ^C; then
  gitstatus="&$gitstatus"
fi

if echo $gitstats | grep -q ^U; then
  gitstatus="^$gitstatus"
fi

if echo $gitstats | grep -q ^?; then
  gitstatus="?$gitstatus"
fi

if echo $gitstats | grep -q ^!; then
  gitstatus="x$gitstatus"
fi


echo $gitstatus
