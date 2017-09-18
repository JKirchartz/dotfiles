setopt promptsubst

PROMPT=$'\n\n%F{red}${(r:$COLUMNS::\#:)}\n\n%F{white}%~\n%F{red}┌─[%F{cyan}%n@%m%F{red}]-[%F{cyan}%D %t%F{red}]-[%F{cyan}%j%F{red}]\n└─[%F{cyan}%!%F{red}]-[%F{cyan}%b\>'

