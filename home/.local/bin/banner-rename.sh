#! /bin/sh
#
# banner-rename.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

prefix=$1
frame=$2
for filename in *.png; do
	if [[ "$filename" = "$prefix"* ]]; then
		echo "skipping $filename: already exists";
	else
		mv "$filename" "${prefix}_frame${frame}-${filename}";
		echo "moved $filename to ${prefix}_frame${frame}-${filename}"
	fi
done;

