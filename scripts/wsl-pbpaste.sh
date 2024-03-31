#!/usr/bin/env bash
# https://web.archive.org/web/20231201064931/https://www.techtronic.us/pbcopy-pbpaste-for-wsl/

# pbpaste for WSL
/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard | sed 's/\r$//' | sed -z '$ s/\n$//'
exit 0

