#!/bin/bash

# easier jekyll post

if [ -z "$1" ]
then
    read -p "Post Title:"  TITLE
else
    TITLE="$1"
fi
FILE=$( echo $TITLE | tr A-Z a-z | tr [:punct:] '' | tr ' ' _ )
FILENAME=$(date '+%Y-%m-%d-')"$FILE"'.md'
echo -e '---\nlayout: post\ntitle: '$TITLE'\npublished: false\ntags:\n---\n' > $FILENAME
