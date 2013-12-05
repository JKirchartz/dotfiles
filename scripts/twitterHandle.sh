#!/bin/bash

URL= "http://twitter.com/" + 
STATUS= $(curl -sL -w "%{http_code}" "$URL" -o /dev/null)

if [ "$STATUS" = "200" ]; then 
    echo "twitter acct exists"
else
    echo "not a twitter acct"
fi
