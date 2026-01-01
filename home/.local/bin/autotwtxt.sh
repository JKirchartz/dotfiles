#! /bin/bash
#
# autotwtxt.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#



fortunedir=$(fortune -f 2>&1 | head -n1 | cut -d' ' -f2)

fortunetxt=$(fortune -ae "$fortunedir" "$XDG_DATA_HOME/fortunes" -s -n 131) # | tr '(\t|\r\n)' ' ' |  tr -s '[:blank:]')


fortunetxt="$fortunetxt #fortune"

echo $fortunetxt


FLIP=$(($(($RANDOM%10))%2))
if [ $FLIP -eq 1 ]; then
	twtxt.sh blinken "$fortunetxt"
	echo "posted to blinken"
else
	twtxt.sh sdf "$fortunetxt"
	echo "posted to sdf"
fi
