#! /bin/sh
#
# trellis_up.sh <path/to/trellis/project>
# Copyright (C) 2017 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


cd "$1/trellis" || exit 1;
vagrant up
cd "../theme" || exit 1;
if [ -n "$TMUX" ]; then
        tmux split-window -v -p 90 "gulp && gulp watch" 'C-m'
else
        gulp && gulp watch
fi

