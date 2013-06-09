#!/bin/bash

# create a new jekyll post
# by supplying a title

if [ -z "$1" ]
then
    read -p "Post Title:"  TITLE
else
    TITLE="$1"
fi
FILE=$( echo $TITLE | tr A-Z a-z | tr -d '[:punct:]' | tr ' ' _  )
FILENAME='unpublished-'"$FILE"'.md'
echo -e '---\nlayout: post\ntitle: '$TITLE'\npublished: false\ntags: article\n---\n' > $FILENAME

if [ -n "$2" ]
then
    echo "$2" >> $FILENAME
fi
