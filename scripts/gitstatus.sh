#! /bin/bash
#
# gitstatus.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


OLDIFS=$IFS
IFS=$'\n'
gitstatus="$(git status -sb --porcelain)"
branch="$(echo "$gitstatus" | head -1 | cut -c4-)"

# check if branch is ahead or behind
remotestatus=""
if [[ "$branch" = *"..."* ]]; then
remotestatus="="
case "$branch" in
  *ahead* ) remotestatus=">" ;;
  *behind* ) remotestatus="<" ;;
  * ) remotestatus="=" ;;
esac
fi

# make branch display-ready
branch="$(echo "$branch" | cut -d'.' -f1)"

# check status of working directory
staged=false
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
added=false
case "$gitstatus" in
  '^A' )
    added=true
    ;;
  '^ A' )
    added=true
    ;;
esac

modified=""
if $unstaged || $untracked;then
  modified="*"
fi
if $staged || $added; then
  modified="+"
fi

# deleted=""
# if echo "$gitstatus" | grep '^ A' &> /dev/null; then
# deleted="-"
# fi


# put it all together
if [[ $remotestatus || $modified != "" ]]; then #
  echo "(${branch}${modified}${remotestatus})"
else
  branch="$(echo "$branch" | cut -d'.' -f1)"
  echo "(${branch})"
fi
IFS=$OLDIFS

