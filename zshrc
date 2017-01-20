setopt promptsubst

~/dotfiles/scripts/motd.sh

source ~/dotfiles/bash_aliases

RPROMPT=$'%F{white}%~'
PROMPT=$'\n\n%F{red}${(r:$COLUMNS::\#:)}\n\n┌─[%F{cyan}%n@%m%F{red}]-[%F{cyan}%D %t%F{red}]-[%F{cyan}%j%F{red}]\n└─[%F{cyan}%!%F{red}]-[%F{cyan}$\>'

