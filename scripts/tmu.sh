#!/bin/bash
# stolen from blinkenshell

sout=`tmux ls`

# Dead screens
#if echo "$sout" | grep dead &> /dev/null
#then
#	echo -n "Dead screen detected, removing... "
#	screen -wipe
#	screen -ls &> /dev/null
#	echo "Done"
#	echo "Press enter to continue"
#	read
#	sout=`screen -ls`
#fi

# No TMUX sessions at all
if echo "$sout" | grep "failed to connect" &> /dev/null
then
	echo "No TMUX sessions found, starting a new one? (y/n)"
	read yn
	if [ "$yn" == "y" ]
	then
		exec tmux new-session -s tmu
	fi
	exit 0
fi

# numscreen=`echo "$sout" | egrep -o "^(\d+)" | cut -d' ' -f1`
numscreen=`echo "$sout" | egrep -o "^(\d+)" | tail -1`

# Multiple TMUX
if [ "$numscreen" -gt 1 ]
then
	echo "Warning, you're running multiple (${numscreen}) screens!"
	echo "Resume the one(s) you don't need and exit: screen -rd <id>"
	echo
	tmux ls
	exit 1
fi

# One TMUX - resume
if [ "$numscreen" -eq 1 ]
then
	echo "Found screen, trying to resume..."
	sleep 1
	exec tmux attach
fi
