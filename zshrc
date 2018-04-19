#------------------------------
# set options
#-----------------------------{{{
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '${HOME}/.zshrc'
autoload -Uz compinit; compinit
autoload -U zmv
setopt promptsubst autocd notify hist_ignore_dups NO_BEEP hist_ignore_space inc_append_history share_history interactivecomments

export PATH=$HOME/dotfiles/scripts:$PATH
export EDITOR="vim" PAGER="less"

HISTFILE="${HOME}/.zshhistory"
HISTSIZE=50000
SAVEHIST=50000


#}}}-----------------------------
# make ZSH vimlike
#-----------------------------{{{

EDITOR=vim

bindkey -v
export KEYTIMEOUT=1
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
# Use vim cli mode
# bindkey '^P' up-history
# bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
# bindkey '^w' backward-kill-word
#
# ctrl-r starts searching history backward
# bindkey '^r' history-incremental-search-backward


#}}}-----------------------------
#detect/install zplug plugins
#-----------------------------{{{

if [[ -a ~/.zplug/init.zsh ]];then
	# load zplug
	source ~/.zplug/init.zsh

	# have zplug manage itself
	zplug 'zplug/zplug', hook-build:'zplug --self-manage'

	zplug "zsh-users/zsh-autosuggestions"
	# zplug "chrissicool/zsh-bash",    defer:3
	zplug "zsh-users/zsh-syntax-highlighting", defer:2
	zplug "sharat87/zsh-vim-mode"
	zplug "rbirnie/oh-my-zsh-keybase"
	zplug "lukechilds/zsh-better-npm-completion"
	zplug "srijanshetty/zsh-pip-completion"
	zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh, hook-build:"zplug clear"

	zplug "plugins/command-not-found",   from:oh-my-zsh

	zplug load


else
	echo "zplug not installed, use:"
	echo "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh"
fi

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi


# }}}----------------------------
# load same aliases/functions as bash
# ----------------------------{{{
source ~/dotfiles/bash_aliases
source ~/dotfiles/bash_functions

# }}}----------------------------
# setup prompt
# ----------------------------{{{
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[cyan]%}%{✚%G%}"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

# if shell's running INSIDE vim, mark it in the prompt (as a white V)
if [ -z "${VIMRUNTIME}" ]; then
  __vim="[";
else
  __vim="(%F{white}V%F{red})-[";
fi

# 	VIM_PROMPT="%{$fg_bold[white]%} [% NORMAL]%  %{$reset_color%}"
# 	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
# 	zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

# setup horizontal rule
__rule=$(printf '\e[0;31m%*s\n\e[m' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '#')

# prompt
PS1=$'\n\n'"%F{red}$__rule"$'\n\n'"%F{white}%d $(git_super_status)"$'\n'"%F{red}┌─[%F{cyan}%n@%m%F{red}]-[%F{cyan}%D{%x %X}%F{red}]-[%F{cyan}%j%F{red}]"$'\n'"%F{red}└─[%F{cyan}%!%F{red}]-$__vim%F{cyan}%(#.#.$)>%F{white}%{$reset_color%}"
PS2="%F{red}└─%F{cyan}>%{$reset_color%}"

#}}}-----------------------------
# run scripts
#-----------------------------{{{
~/dotfiles/scripts/motd.sh


# }}} fold up this file
# vim: foldmethod=marker
