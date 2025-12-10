#! /bin/sh
#
# appcfg-completion.sh
#
# Copyleft (ↄ) 2015 kirch <kirch@arp>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#


_appcfg() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMPWORDS[COMP_CWORD]}"
  prev="${COMPWORDS[COMP_CWORD-1]}"
  opts="help download_app request_logs update update_cron update_dispatch\
    update_dos update_indexes update_queues vacuum_indexes"
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
} 

complete -F _appcfg ~/google_appengine/appcfg.py
