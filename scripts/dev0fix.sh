#!/bin/bash

SSHFSPID=$(ps aux | grep [s]shfs | awk '{print $2}');
if [[ $SSHFSPID =~ "^[0-9]+$" ]]
then
    echo "killing sshfs, pid: $SSHFSPID"
    kill -9 $SSHFSPID
else
    echo "cannot find sshfs pid... moving on..."
fi
echo "unmounting dev0"
sudo umount -f ~/projects/dev0
echo "reconnecting dev0"
sshfs joel.kirchartz@dev0:/home/joel.kirchartz/projects/ ~/projects/dev0 -ovolname=dev0,reconnect


