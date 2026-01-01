#!/bin/bash

# create a new github repo
# copied from
# https://coderwall.com/p/mnwcog

repo_name=$1
user_name='jkirchartz'
test -z $repo_name && echo "Repo name required." 1>&2 && exit 1

curl -u $user_name https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"

git init
git remote add origin "https://github.com/$user_name/$repo_name.git"
