#! /bin/sh
#
# wotd.sh
#
# Copyleft (ↄ) 2016 kirch <kirch@arp>
#
# Distributed under terms of the MIT license.
#


# replace with a dictionary-finding function ala cowsay.sh & fortune.sh
DICTIONARY=/usr/share/dict/words
if [ -f $DICTIONARY ]; then
  # hat-tip to flukiluke@blinkenshell for this hash:
  n=$(echo $(date +%D|md5sum) $(wc -l ${DICTIONARY}) |  awk '{print \
    strtonum("0x"$1)%$3}')
  echo -n "Today's secret word is \"$(sed "$n q;d" ${DICTIONARY})"
  echo -n "\", now you all remember what to do when you hear the secret"
  echo " word, RIGHT!?"
fi

