#! /bin/sh
#
# getops_test.sh
#
# Copyleft (ↄ) 2019 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


echo "getops will now parse $@"

while getopts :ab:c name
do
  case $name in
    # options that are just a flag can set things like so:
    a|c) echo "$name? OK!";;
    # options that have data can display that data like so:
    b) echo "$name? that's $OPTARG, ok!";;
    # and if the option isn't there, complain about them using it:
    *) echo "$name? invalid arg";;
  esac
done

# OPTIND contains the index of the commandline options
# after looping through the options above, this will reset the index
# so that $1 is the first variable instead of the first flag provided.
shift $(($OPTIND -1))

echo "after the flags, you wrote this: $@"
