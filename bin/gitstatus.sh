#! /bin/bash
#
# gitstatus.sh
# a simplified git prompt script, parses status --porcelain into something
# resembling the official git-prompt.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


function gitstatus() {
  OLDIFS=$IFS
  IFS=$'\n'
  gitstatus="$(git status -sb --porcelain 2>&1)"
  if [[ $gitstatus = "fatal"* ]]; then
    # abort if not a git repo
    exit
  fi
  branch="$(echo "$gitstatus" | head -1 | cut -c4-)"

  # check if branch is ahead or behind
  remotestatus=""
  if [[ "$branch" = *"..."* ]]; then
  case "$branch" in
    *ahead* ) remotestatus=">" ;;
    *behind* ) remotestatus="<" ;;
    * ) remotestatus="=" ;;
  esac
  fi

  # remove remote branch name from display (if applicable)
  branch=$(printf '%s\n' "${branch//.../$'\n'}" | head -1)

  # check status of working directory
  unstaged=false
  if echo "$gitstatus" | grep '^ M' &> /dev/null; then
    unstaged=true
  fi
  untracked=false
  if echo "$gitstatus" | grep '^??' &> /dev/null; then
    untracked=true
  fi

  staged=false
  if echo "$gitstatus" | grep '^M' &> /dev/null; then
    staged=true
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
    modified=" *"
  fi
  if $staged || $added; then
    modified=" +"
  fi

  # put it all together
  echo "(${branch}${modified}${remotestatus})"
  IFS=$OLDIFS

}
