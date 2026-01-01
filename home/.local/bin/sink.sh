#!/bin/sh
#
# sink -- play an ancient Discordian game with files
# hacked up by lhos on 32 Afm, 3160
# All rites reserved.
# This program is part of the Emperor Norton Utilities.

if [ $# -eq 0 ] ; then
  echo "usage:  $0 file(s)"
  exit 1
fi

while [ $# -gt 0 ] 
do
  rm $1
  if [ $? -eq 0 ]
  then echo "I sank $1!!!"
  fi
  shift
done
