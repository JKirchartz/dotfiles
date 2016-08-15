#!/bin/bash

SEARCHER="ack"
VCS=""

if [ -d ".svn" ]; then
	VCS="svn"
fi

if [ -d ".git" ]; then
	VCS="git"
fi

if [ -d ".hg" ]; then
	VCS="hg"
fi

if hash ack 2>/dev/null; then
	SEARCHER="grep"
fi

if [ ! -z "$VCS" ]; then
	if eval "$VCS diff | $SEARCHER var_dump\|die\|console."; then
		echo "CLEAN!"
	else
		echo "DIRTY!"
		eval "$SEARCHER var_dump\|die\|console."
	fi
else
	echo "not a repository"
fi
