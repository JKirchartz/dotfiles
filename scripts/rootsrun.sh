#! /bin/sh
#
# rootsrun.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

if [ $# -eq 0 ]; then
  echo "please provide the directory for this project"
  echo "$> rootsrun.sh ~/tprojects/example.dev"
  exit;
fi

# stop currently running vagrant boxes
vagrant global-status | grep running | cut -d' ' -f1 | while read -r line; do
  vagrant halt "$line"
done


LOCATION="$1"
cd "$LOCATION/trellis" || echo "failed to cd to trellis" && exit
vagrant up
cd "$LOCATION/theme" || exit
gulp && gulp watch
