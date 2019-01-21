#! /bin/bash

tput civis # hide cursor
LINES=$(tput lines)
COLUMNS=$(tput cols)
snowflakes=("❄" "❃" "❅" "❆" "❇" "❈" "❉")
clear

flake=${snowflakes[$RANDOM % ${#snowflakes[*]}]}
banner=$(figlet -c -f slant -w $COLUMNS "let it snow")

while :;do
  echo $LINES $COLUMNS $((RANDOM%COLUMNS)) "$flake"
  sleep 0.1
done | gawk '{ a[$3]=0; for(x in a) { o=a[x]; a[x]=a[x]+1; printf "\033[%s;%sH ",o,x; printf "\033[%s;%sH%s \033[0;0H",a[x],x,$4; } }'

#trap "kill $!" EXIT
#while :;do echo -n; done
#kill $! && trap " " EXIT

tput cnorm # normal cursor
