#!/bin/bash

# easier git commit & push
# prompts for message if missing

if [ -z "$1" ]
then
    read -p "Commit Message:" MSG
else
    MSG="$1"
fi
git add .
git commit -am "$MSG"
git push
