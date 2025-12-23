#! /bin/bash
#
# finddups.sh
# Copyright (C) 2017 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


find . -size 20 \! -type d -exec cksum {} \; | sort | tee /tmp/f.tmp | cut -f 1,2 -d ' ' | uniq -d | grep -hif - /tmp/f.tmp > dup.txt
