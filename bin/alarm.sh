#!/bin/bash

if[ $# > 0 ]; then
    if[ $# >= 2 ]; then
        sleep $1; say $2; echo $2;
    fi
else
    echo -e "How long?"
    read alarmTime
    echo -e "What do you want me to say?"
    read Message
    sleep $alarmTime; say $Message; echo $Message;
fi
