#!/bin/bash
# customizations
_home="home_computer:/Users/$USER/irssi_backup/"
_now=$(date +"%Y_%m_%d")
# DO NOT CHANGE ANYTHING BELOW THIS LINE
cd "$HOME" && tar > /dev/null zcvf "$HOME/backup/irssi_backup-$_now.tar.gz" .irssi/ 2> >(grep -v 'socket ignored' >&2)
if ! /usr/bin/scp -P 1013 -q "$HOME/backup/irssi_backup-$_now.tar.gz" "$_home"
then
  echo "Transfer failed!"
  echo "Try again later"
  exit 1
else
  echo "Transfer Succeess!"
  rm -f "$HOME/backup/irssi_backup-$_now.tar.gz"
fi
