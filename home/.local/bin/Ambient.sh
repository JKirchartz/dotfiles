#! /bin/sh
#
# Ambient.sh
#
# Copyleft (ↄ) 2020 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

# convert youtube link to stretched

name=$(youtube-dl -x --audio-format wav $1 --output "%(id)s.%(ext)s" --get-filename)

paulstretch_stereo.py -s 8 $name "${name}.8.wav"
