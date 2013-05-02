#!/bin/bash

URL= "http://twitter.com/pdq"
STATUS= $(curl -sL -w "%{http_code}" "$URL" -o /dev/null)

if [ "$STATUS" = "200" ]; then 
    echo "yup"
fi
