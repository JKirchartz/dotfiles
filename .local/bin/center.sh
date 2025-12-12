#! /bin/sh
#
# center.sh
#
# Copyleft (ↄ) 2019 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

inputcols=$(echo "$@" | wc -c | xargs echo -n);
totalcols=$(tput cols)
outputspan=$((($totalcols-$inputcols)/2))
padding=$(printf "%*s" $outputspan)

# pad
echo $@ | sed -e "s/^/$padding/"

