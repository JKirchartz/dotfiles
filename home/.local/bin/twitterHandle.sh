#!/bin/bash

NAME=$1
if [ ${#NAME} -gt 15 ]; then
    echo "too long for twitter handle"
  else
    URL="http://twitter.com/$NAME"
    STATUS=$(curl -sIL -o /dev/null -w '%{http_code}' "$URL")
    if [ "$STATUS" = "404" ]; then
      echo "not a twitter acct"
    elif [ "$STATUS" = "200" ]; then
      echo "twitter acct exists"
    else
      echo "IDK, I'm just a dumb script, see for yourself"
      echo $URL
    fi
fi
