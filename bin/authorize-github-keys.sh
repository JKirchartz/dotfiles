#! /bin/sh
#
# authorize-github-keys.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


if [ "$#" -gt 0 ]; then
  username="$1"
else
  echo "Please enter a github username"
  read -r username
fi

keys=$(curl http://github.com/"${username}".keys)

if [ "$keys" -gt 0 ]; then
  printf "%s" "$keys" >> ~/.ssh/authorized_keys
  vim -u NONE ~/.ssh/authorized_keys +'sort u|wq'
fi

