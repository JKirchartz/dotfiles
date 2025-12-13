#!/bin/bash
# dev0 was a server whose sshfs loved to hang, no matter what I tried it got 
# stuck, so I had to kill it and bring it back to life -- luckily I don't have 
# to deal with this anymore, but I'm keeping the script just in case
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


