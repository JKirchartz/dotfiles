#! /bin/bash

ffmpeg -i "$1" -filter:v "fps=15,scale=120:90,hue=s=0" -ac 1 "$2"
