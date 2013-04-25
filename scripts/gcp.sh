#!/bin/bash

# easier git commit & push
# prompts for message if missing

git add .
if [ -z "$1" ]
then
    git commit -a
else
    git commit -am "$1"
fi
git push
