#! /bin/sh
#
# unlink.sh (was unmake before 2025, but it really unlinks)
#
# Copyleft (ↄ) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

# find all symlinks in $HOME
for f in $(find $HOME -maxdepth 3 -type l)
do
  # find where the link points to
  l=$(readlink "$f")
  # if linked file exists and contains the "dotfiles" dir
  if [ -e "$l" ] && [ -z "${l##*$HOME/dotfiles*}" ]; then
    # copy dotfiles to their symlinked location
    echo "unlinking $f"
    unlink "$f"
    echo "copying $l to $f"
    cp -r --remove-destination "$l" "$f"
  fi
done
