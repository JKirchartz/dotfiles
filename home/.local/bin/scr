#!/bin/bash
# stolen from blinkenshell

sout=`screen -ls`

# Dead screens
if echo "$sout" | grep dead &> /dev/null
then
	echo -n "Dead screen detected, removing... "
	screen -wipe
	screen -ls &> /dev/null
	echo "Done"
	echo "Press enter to continue"
	read
	sout=`screen -ls`
fi

# No screens at all
if echo "$sout" | grep "No Sockets found" &> /dev/null
then
	echo "No screens found, starting a new one? (y/n)"
	read yn
	if [ "$yn" == "y" ]
	then
		exec screen -S scr
	fi
	exit 0
fi

numscreen=`echo "$sout" | egrep -o "([0-9]*) Socket" | cut -d' ' -f1`

# Multiple screens
if [ "$numscreen" -gt 1 ]
then
	echo "Warning, you're running multiple (${numscreen}) screens!"
	echo "Resume the one(s) you don't need and exit: screen -rd <id>"
	echo
	screen -ls
	exit 1
fi

# One screen - resume
if [ "$numscreen" -eq 1 ]
then
	echo "Found screen, trying to resume..."
	sleep 1
	exec screen -rd
fi
