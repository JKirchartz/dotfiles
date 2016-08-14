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
	eval "$VCS diff | $SEARCHER var_dump"
	eval "$VCS diff | $SEARCHER die"
	eval "$VCS diff | $SEARCHER console."
else
	echo "not a repository"
fi
