#! /bin/bash
#
# banner-adsize.sh
# Copyright (C) 2018 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


for dir in ./*; do
	if [[ -d "$dir" && ! -L "$dir" ]]; then
		dir="${dir%/}"
		dir="${dir##*/}"
		dim=(${dir//x/ })
		find -E "./$dir" -regex '.*\.(html)' -exec sed -i "s/width=[[:digit:]]\+,height=[[:digit:]]\+/width=${dim[0]},height=${dim[1]}/g" {} \;
	 fi;
 done;
