#!/bin/bash
git submodule foreach git checkout master
git submodule foreach git pull
read -p "commit changes? [Y/n]" answer
if [ $answer == "n" ]; then
    exit;
fi
git commit -am "update submodules"
