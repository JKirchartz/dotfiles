#! /bin/sh
#
# trellis-wp-update.sh
# Copyright (C) 2017 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#
# exit on error:
set -e


# checkout, pull, and update each branch

git checkout master

git pull

cd site

composer update johnpbloch/wordpress

git commit -am 'WP security update'

git push

git checkout env/staging

git pull

git merge master

git push

git checkout env/prod

git pull

git merge master

git push

git checkout master
