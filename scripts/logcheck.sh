#!/bin/bash

if [ `ls .svn` ]
then
    svn diff | grep "var_dump"
    svn diff | grep "die"
    svn diff | grep "console."
fi

if [ `ls .git` ]
then
    git diff | grep "var_dump"
    git diff | grep "die"
    git diff | grep "console."
fi
