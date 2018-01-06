#! /bin/zsh
#
# banner-resize.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#
input=$1
output=$2


INdimensions=("${(@s/x/)input}")
INwidth=INdimensions[0]
INheight=INdimensions[1]
OUTdimensions=("${(@s/x/)input}")
OUTwidth=OUTdimensions[0]
OUTheight=OUTdimensions[1]

autoload zmv && zmv "(*)${input}(*)" '$1${output}$2'
find -E ./ -regex '.*\.(html|js|less)' -exec sed -i -e "s/${input}/${output}/g" \
   -e "0,/${INwidth}/s/${INwidth}/${OUTwidth}/" \
   -e "0,/${INheight}/s/${INheight}/${OUTheight}/" {} \;
