#! /bin/sh
#
# weather.sh
# Show a 3-day forcast (updates hourly)
# for more information `curl wttr.in/:help`
#
# Copyleft (ↄ) 2016 jkirchartz <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

while true
do
  printf "\ec" # clear screen
	# get weather for pittsburgh (via IATA airport code), remove cruft
  curl -s wttr.in/PIT?1 2>/dev/null | head -n 17
  sleep 3600 # one hour
done

