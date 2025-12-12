#!/bin/bash
# http://codegolf.stackexchange.com/a/50149/1095
printf -vs %$2s"$1"
for((;++i<${#1}+$2;)){
echo "${s:i:$2}"
}
