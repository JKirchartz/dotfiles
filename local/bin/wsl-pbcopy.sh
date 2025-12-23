#!/usr/bin/env bash
# https://web.archive.org/web/20231201064931/https://www.techtronic.us/pbcopy-pbpaste-for-wsl/

# pbcopy for wsl
tee <&0 | /mnt/c/Windows/System32/clip.exe
exit 0
