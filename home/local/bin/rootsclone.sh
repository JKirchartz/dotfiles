#! /bin/sh
#
# rootsclone.sh
# clone a roots.io project & set it up
# Copyright (C) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


current_dir=$(pwd)
project_dir="$current_dir/$2"

git clone "$1" "$2"

cd "$project_dir/trellis" || exit
ansible-galaxy install -r requirements.yml

cd "$project_dir/site/web/app/themes" || exit
theme=$(find . -mindepth 1 -maxdepth 1 -type d | head -n 1)
cd "$theme" || exit
npm install && bower install

cd "$project_dir" || exit


echo "to finalize the install, transfer the remote database/uploads directory to the new vagrant VM"
