#!/bin/bash
git submodule foreach git checkout master
git submodule foreach git pull
git submodule update --init --recursive
read -p "commit changes? [Y/n]" answer
if [ $answer == "n" ]; then
    exit;
fi
git commit -am "update submodules"
