#! /bin/bash
#
# vagrant-shuffle.sh
# Copyright (C) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

if [[ -f ./Vagrantfile ]]; then
	vag=$(vagrant global-status | grep running | cut -d' ' -f1)

	if [[ -z "${vag// }" ]]; then
		vagrant halt "$vag"
	fi;
        vagrant up
else
        echo "please run this in a directory with a vagrant file"
fi
