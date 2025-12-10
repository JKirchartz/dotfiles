#!/bin/bash
for file in `find ./ -type d -maxdepth 3` ; do
    gc=`find ./ .git -type d -maxdepth 1`
    if [[ -d gc ]]; then
        (cd $file && git cherry -v)
    fi
done
