#!/bin/bash

cols=$(tput cols)
for ((x = 0; x < cols; x++)); do
    printf %s \#
done
echo ""
