#!/bin/bash

# much easier commit, gets message from whatthecommit.com
# commit messages are completely random, completely. It may
# be NSFW, it's probably best not to use this, but it's fun 
# to live dangerous

WTC=$(curl -s http://whatthecommit.com/index.txt)
MSG="'"$WTC"'"
echo $MSG
git add .
git commit -am "$MSG"
git push
