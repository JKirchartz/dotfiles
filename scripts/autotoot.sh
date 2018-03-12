#! /bin/sh
#
# autotoot.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#



fortunedir=$(fortune -f 2>&1 | head -n1 | cut -d' ' -f2)

fortunetxt=$(fortune -ae "$fortunedir" "$HOME/dotfiles/scripts/fortune/" -s -n 491) # | tr '(\t|\r\n)' ' ' |  tr -s '[:blank:]')


fortunetxt="$fortunetxt #fortune"

echo $fortunetxt

toot post "$fortunetxt"
