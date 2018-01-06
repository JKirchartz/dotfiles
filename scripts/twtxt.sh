#! /bin/bash
#
# twtxt.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

location="html"

if [[ "$1" == "blinken" ]]; then
		location="public_html"
fi

ssh $1 "echo `date +%FT%T%:z`\t\"$2\" >> ~/$location/twtxt.txt"
