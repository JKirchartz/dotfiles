#! /bin/sh

LABEL=$(uname -a | tr '[:upper:]' '[:lower:]')

case "$LABEL" in
  *alpine*) doas apk add git vim tmux fortune cowsay shellcheck;;
  *arch*) sudo pacman -S git vim tmux fortune-mod cowsay shellcheck keychain;;
  *debian*|*ubuntu*) sudo apt-get install git vim tmux fortune cowsay shellcheck keychain;;
  *darwin*) # I may never touch a mac again, but I guess I'll be prepared?
    if command -v brew  >/dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ -f "$HOME/dotfiles/Brewfile" ]; then
      cd "$HOME/dotfiles/Brewfile" && brew bundle || exit
    else
      brew install git vim tmux fortune cowsay shellcheck keychain
    fi
    ;;
esac
