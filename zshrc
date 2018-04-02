#------------------------------
# set options
#-----------------------------{{{
setopt promptsubst


#}}}-----------------------------
# run scripts
#-----------------------------{{{
~/dotfiles/scripts/motd.sh

#}}}-----------------------------
#detect/install zplug plugins
#-----------------------------{{{

if [[ -a ~/.zplug/init.zsh ]];then
	# load zplug
	source ~/.zplug/init.zsh

	# have zplug manage itself
	zplug 'zplug/zplug', hook-build:'zplug --self-manage'

	zplug "zsh-users/zsh-autosuggestions"
	zplug "chrissicool/zsh-bash"
	zplug "sharat87/zsh-vim-mode"
	zplug "rbirnie/oh-my-zsh-keybase"
	zplug "lukechilds/zsh-better-npm-completion"
	zplug "srijanshetty/zsh-pip-completion"

	zplug "plugins/command-not-found",   from:oh-my-zsh
	zplug "plugins/git",   from:oh-my-zsh


else
	echo "zplug not installed, use:"
	echo "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh"
fi


# }}}----------------------------
# load same aliases as bash
# ----------------------------{{{
source ~/dotfiles/bash_aliases

# }}}----------------------------
# setup prompt
# ----------------------------{{{
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"

# if shell's running INSIDE vim, mark it in the prompt (as a white V)
if [ -z "${VIMRUNTIME}" ]; then
  __vim="[";
else
  __vim="(%F{white}V%F{red})-[";
fi

# setup horizontal rule
__rule=$(printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#')

# prompt
PS1=$'\n\n'"%F{red}$__rule"$'\n\n'"%F{white}%d $(git_prompt_info)"$'\n'"%F{red}┌─[%F{cyan}%n@%m%F{red}]-[%F{cyan}%D{%x %X}%F{red}]-[%F{cyan}%j%F{red}]"$'\n'"%F{red}└─[%F{cyan}%!%F{red}]-$__vim%F{cyan}%(#.#.$)>%F{white}%{$reset_color%}"
PS2="%F{red}└─%F{cyan}>%{$reset_color%}"


# fold up this file
# vim:foldmethod=marker
