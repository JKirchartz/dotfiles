#!/bin/sh
############################
# dfm - DotFile Manager
#
# copyleft 2025 - jkirchartz (see NPL - Neccesary Public Licence)
#
# this is basically a dumber replacement for GNU stow... go figure
# I didn't really like stow or any of the alternatives, so I'm just getting the files I want how I want.
############################
# PS4=">_> "                  # just for the looks... <_<
# set -o xtrace               # show everything as it happens ... except for the stuff above this line...

########
# make sure we know about all our variables, etc...
##

src_dir=$(git rev-parse --show-toplevel)        # this dotfiles directory
old_dir="${src_dir}_old"                        # old dotfiles backup directory

if [ ! -d "$src_dir" ]; then
	echo "this should be run from the root of my dotfiles directory..."
	src_dir=$(dirname "$0")
	[ ! -e "$src_dir" ] && echo "    ... $src_dir, really?"
	
fi

# shellcheck source=./home/.profile
. "$src_dir"/home/.profile


########
# provision the apps I like to use...
###

provision () {
  LABEL=$(uname -a | tr '[:upper:]' '[:lower:]')
  case "$LABEL" in
    *alpine*) doas apk add git vim tmux fortune cowsay shellcheck;;
    *arch*) sudo pacman -S git vim tmux fortune-mod cowsay shellcheck keychain;;
    *debian*|*ubuntu*) sudo apt-get install git vim tmux fortune-mod cowsay shellcheck keychain;;
    *darwin*) # I may never touch a mac again, but I guess I'll be prepared?
      if command -v brew  >/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      if [ -f "$src_dir/Brewfile" ]; then
        cd "$src_dir/Brewfile" && brew bundle || exit
      else
        brew install git vim tmux fortune cowsay shellcheck keychain
      fi
      ;;
  esac

  vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"
}

########
# loop through files and symlinks them...
###

linkfiles() {
	# move any existing dotfiles in $HOME to dotfiles_old directory, then create symlinks
	# from the $HOME directory to it's place in the dotfiles/home directory.
	# note: ${HOME:?} makes sure $HOME never expands to `/` (via shellcheck)
	for file in "$@"; do
		# if it's a file and is not a link, back it up
		[ -f "${HOME:?}/$file" ] && [ ! -L "${HOME:?}/$file" ] && mv "${HOME:?}/$file" "$old_dir"
		# if it's not file or link, it's probably a broken link?
		rm -rf "${HOME:?}/$file"
		ln -nsfv "${src_dir}/home/${file}" "${HOME:?}/$file" # Not Safe For Verbose(?)
	done
}

########
# actually install the dotfiles...
###

install() {
	# we should be here, but maybe for some reason I might not be? IDK
	cd "$src_dir" || exit

	# checkout submodules; the recursiveneess will setup vim, fortunes, etc
	git submodule init
	git submodule update --recursive --remote

	# make fortunes
	echo "install fortunes..."
	cd "$src_dir/home/.local/share/fortunes" && make

	# we should definitely need to go back now...
	cd "$src_dir" || exit

	# these `linkfiles` calls might be better served with something like
	# `readarray -t filelist < <(git ls-files...)` (or, mapfiles instead of
	# readarray) to be like `linkfiles $filearray` or something
	# -- but like Darkwing Duck always said: let's get dangerous.

	echo "install dotfiles..."
	# search the home directory for files we want, and cut it down to just the ones we want to symlink now (everything but local)
	linkfiles $(git ls-files home/ --deduplicate | grep -vE ".local" | sed "s|home/||" | cut -d/ -f1-2 | sort -u)

	# OK, now let's do local...

	[ ! -d "${HOME}/.local" ] && mkdir "${HOME}/.local"
	[ ! -e "${HOME}/.local/bin" ] && ln -nsfv "${src_dir}/home/.local/bin" "${HOME}/.local/bin"
	linkfiles $(git ls-files home/.local/share --deduplicate | sed "s|home/||" | sort -u)

	vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"
}


########
# convert the symlinks from my dotfiles into actual files...
###

unlink() {
  # find all symlinks in $HOME (up to 3 folders deep, because I'm pretty sure
  # that's how deep the install script goes...)
  find "$HOME" -maxdepth 3 -type l -print0 > tmp
  while IFS= read -r f
  do
    # find where the link points to
    l=$(readlink "$f")
    # if linked file exists and contains this "dotfiles" dir
    if [ -e "$l" ] && [ -z "${l##*"$src_dir"*}" ]; then
      # copy dotfiles to their symlinked location
      echo "unlinking $f"
      unlink "$f"
      echo "copying $l to $f"
      cp -r --remove-destination "$l" "$f"
    fi
  done < tmp
}

install_vim() {
  LABEL=$(uname -a | tr '[:upper:]' '[:lower:]')
  case "$LABEL" in
    *alpine*) doas apk add git make clang libtool-bin libxt-dev libncurses-dev;;
    *arch*) sudo pacman -S git make clang libtool-bin libxt-dev libncurses-dev;;
    *debian*|*ubuntu*) sudo apt-get install git make clang libtool-bin libxt-dev libncurses-dev;;
  esac
  git clone https://github.com/vim/vim.git
  cd vim/src || echo "no vim/src?" && exit
  make
  echo "now try:"
  echo "    cd ${src_dir}/vim/src && make test && make install"
}

install_fzf() {
  KERNEL=$(uname -s | tr '[:upper:]' '[:lower:]')
	ARCHITECTURE=$(dpkg --print-architecture)
	# scrape for URLs and find one that matches our Kernel/Architecture`
	URI=$(curl -Ls https://github.com/junegunn/fzf/releases | grep -oP 'href="\K[^"]+' | grep $ARCHITECTURE | grep $KERNEL)
	wget "https://github.com${URI}"
	FILE=$(echo "$URI" | rev | cut -d/ -f1 | rev)
	tar -xvzf "$FILE" -C "${src_dir}/home/.local/bin"
	rm -rf "$FILE"
}

case $1 in
  install_vim) install_vim;;
  install_fzf) install_fzf;;
  install) install;;
  provision) provision;;
  unlink) unlink;;
  setup) install && provision;;
  all) install && provision && unlink;;
  help|*)
    echo "dfm - the dumb dotfile manager (specifically hacked up for these dotfiles)\n \
    dfm, or dfm help: show this message \n \
    dfm install: install all dotfiles \n \
    dfm provision: try to install things I need/want \n \
    dfm unlink: replace dotfiles symlinks with the actual files... :(after which we can delete this dotfiles repo) \n \
    dfm setup: try to do the whole shebang :(probably want this for working on things & updating dotfiles) \n \
    dfm install_vim: try to install dependencies and build vim (experimental) \n \
    dfm install_fzf: try to install dependencies and build fzf (experimental) \n \
    dfm all: try to do the whole shebang :(probably don't want this unless you plan to delete the repo)" | column -t -s:
  ;;
esac;
