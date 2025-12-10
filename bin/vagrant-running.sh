#! /bin/sh
#
# vagrant-running.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

status=`vagrant global-status`
echo "$status" | head -n 2
echo "$status" | grep running



