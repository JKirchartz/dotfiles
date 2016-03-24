#! /bin/sh
#
# buildguild.sh
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL license.
#


NOWDAY=$(date '+%d')
NOWMONTH=$(date '+%B')
BGDAY=$(ncal | grep We | awk '{print $ 3}')

if [ $NOWDAY -gt $BGDAY ]; then
  echo "${NOWMONTH}'s Build Guild has already happened"
  BGDAY=$(ncal -A1 -B-1 | grep We | awk '{print $ 3}')
  NOWMONTH=$(ncal -A1 -B-1 | head -n 1 | awk '{print $1}')
fi
echo "The next Build Guild is ${NOWMONTH} ${BGDAY}th"




