#! /bin/zsh
#
# banner-resize.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#
input=$1
output=$2
autoload zmv && zmv "(*)${input}(*)" '$1${output}$2'
find -E ./ -regex '.*\.(html|js|less)' -exec sed -i "s/${input}/${output}/g" {} \;
