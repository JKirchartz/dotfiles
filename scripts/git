#!/usr/bin/env bash
# change git author/email based on repo location (or other conditionals)
# from: https://stackoverflow.com/a/48276728/276250

# "Real" git is the second one returned by 'which'
REAL_GIT=$(which -a git | uniq | sed -n 2p)

# Does the remote "origin" point to GitHub?
if ("$REAL_GIT" remote -v 2>/dev/null |
    grep '^origin\b.*github.com.*(push)$' >/dev/null 2>&1); then

    # Yes.  Set username and email that you use on GitHub.
    export GIT_AUTHOR_NAME='JKirchartz'
    export GIT_AUTHOR_EMAIL='JKirchartz@gmail.com'

fi

"$REAL_GIT" "$@"
