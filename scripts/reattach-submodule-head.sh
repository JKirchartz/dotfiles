#! /bin/sh
#
# reattach submodule head
#
# Copyleft (ↄ) 2018 JKirchartz me@jkirchartz.com
#
# Distributed under terms of the WTFPL license.
#

commit=$(git rev-parse --short HEAD)

echo $commit

git checkout -b $commit

# git checkout -b $commit
# git checkout master
# git rebase $commit
# git branch -D $commit
