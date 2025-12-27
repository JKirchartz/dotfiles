#!/bin/bash
# http://code.runnable.com/U5fa2rSj-Ch8HAkw/make-it-fire-in-the-terminal-for-shell-bash-animations-and-fun
X=`tput cols` Y=`tput lines` e=echo M=`eval $e {1..$[X*Y]}` P=`eval $e {1..$X}`;
B=(' ' '\E[0;31m.' '\E[0;31m:' '\E[1;31m+' '\E[0;33m+' '\E[1;33mU' '\E[1;33mW');
$e -e "\E[2J\E[?25l" ; while true; do p=''; for j in  $P; do p=$p$[$RANDOM%2*9];
done;O=${C:0:$[X*(Y-1)]}$p;C='' S='';for p in $M;do #  _-=[ BruXy.RegNet.CZ ]=-_
read a b c d <<< "${O:$[p+X-1]:1} ${O:$[p+X]:1} ${O:$[p+X+1]:1} ${O:$[p+X+X]:1}"
v=$[(a+b+c+d)/4] C=$C$v S=$S${B[$v]}; done; printf "\E[1;1f$S"; done  # (c) 2012
