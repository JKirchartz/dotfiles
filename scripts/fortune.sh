#! /usr/bin/env bash
#
# fortune.sh
# use my custom fortune file combined with whatever fortunes are on the system
# give all fortune files equal respect (IDK why, egalitarianism?)
# Copyleft (Ɔ) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#
#
#

fortunedir=$(fortune -f 2>&1 | head -n1 | cut -d' ' -f2)
FLIP=$((RANDOM % 2))

if [ $FLIP -eq 1 ]
then
  fortunedir="$HOME/dotfiles/scripts/fortune/"
fi

fortune -ae "$fortunedir"  | tr '\t' ' ' |  tr -s '\s\n'
