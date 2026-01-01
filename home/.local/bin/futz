#!/bin/bash

# send a note to myself with futz.me

if [ -z "$1" ]
then
    read -p "Futz what?" MSG 
else 
    MSG="$1"
fi
#replace with your username, please don't spam me!
OUTPUT=$(echo $MSG | tr ' ' + ) 
curl -Ls "futz.me/jkirchartz%20""$OUTPUT" > /dev/null

