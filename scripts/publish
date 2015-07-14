#!/bin/bash

# publish jekyll post made with new_post.sh

if [ -z "$1" ]
then
    read -p "Post filename:"  FILENAME
else
    FILENAME="$1"
fi
if [ -f "$FILENAME" ] 
then
    NEWFILE=$(echo $(date +%Y-%m-%d)$(echo $FILENAME | cut -c12-1000))
    sed -e 4d $FILENAME > $NEWFILE
    rm -f $FILENAME
else
    echo "not a filename"
fi
