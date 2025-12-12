#! /bin/sh
#
# vote_evil.sh
#
# Copyleft (ↄ) 2015 jkirchartz <jkirchartz@jkirchartz0.pit.corp.google.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

curl 'http://good-v-evil.com/ajax/vote.php' -H 'Cookie: __utmt=1; __utma=201426951.1224526508.1446489352.1446489352.1446489352.1; __utmb=201426951.1.10.1446489352; __utmc=201426951; __utmz=201426951.1446489352.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __CJ_vote=%7B%22side%22%3A%20%22evil%22%2C%20%22timestamp%22%3A%201446489368%7D' -H 'Origin: http://good-v-evil.com' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36' -H 'Content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: text/javascript, text/html, application/xml, text/xml, */*' -H 'X-Prototype-Version: 1.6.1' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'Referer: http://good-v-evil.com/' --data 'side=evil&_=' --compressed
