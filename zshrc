#------------------------------
# set options
#-----------------------------{{{
# autoload bashcompinit && bashcompinit
# source '${HOME}/dotfiles/scripts/wp-completion.bash'
autoload -Uz compinit && compinit
autoload -U zmv

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '${HOME}/.zshrc'
setopt promptsubst autocd notify hist_ignore_dups NO_BEEP hist_ignore_space inc_append_history share_history interactivecomments

export PATH=$HOME/dotfiles/scripts:$PATH
export PATH=$HOME/projects/ghint:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
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

  zplug "jkirchartz/kirch-zsh-theme", as:theme
  zplug "zsh-users/zsh-autosuggestions"
  # zplug "chrissicool/zsh-bash",    defer:3
  zplug "arzzen/calc.plugin.zsh"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "sharat87/zsh-vim-mode"
  zplug "rbirnie/oh-my-zsh-keybase"
  zplug "lukechilds/zsh-better-npm-completion"
  zplug "srijanshetty/zsh-pip-completion"
  zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh, hook-build:"stack setup && stack build && stack install && zplug clear"

  zplug "plugins/command-not-found",   from:oh-my-zsh

  zplug load

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

else
  echo "zplug not installed, use:"
  echo "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh"
fi



# }}}----------------------------
# load same aliases/functions as bash
# ----------------------------{{{
source ~/dotfiles/bash_aliases
source ~/dotfiles/bash_functions

#}}}-----------------------------
# run scripts
#-----------------------------{{{
~/dotfiles/scripts/motd.sh


# }}} fold up this file
# vim: foldmethod=marker
export PATH="/usr/local/opt/mozjpeg/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
