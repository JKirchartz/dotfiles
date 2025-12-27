#! /bin/sh
#
# screenshot.sh
#
# Copyleft (ↄ) 2016 kirch <kirch@arp>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


DATE=$(date +"%Y%m%d%H%M%S")
import -window root "$HOME/Pictures/ss$DATE.png"
