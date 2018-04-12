#!/bin/bash
############################
# .make.sh
# On *nix this script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Cygwin/msys will have ~/dotfiles copied into the home directory
############################

#########
# Variables
###

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
case "$OSTYPE" in
    darwin*)
        # Files for OSX
        echo "Preparing files for OSX"
				files="tern-config jshintrc ackrc inputrc zshrc bashrc bash_profile vimrc vim tmux.conf slate ssh gitconfig screenrc scss-lint.yml"
        echo "Installing Homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "Installing required software via Homebrew"
        brew install iterm2 tmux ack bash cowsay fortune vim reattach-to-user-namespace
        ;;
    msys|cygwin)
        # Files for cygwin & msys << obsoleted by windows 10 anniversary release
        echo "Preparing files for *doze"
				files="tern-config inputrc zshrc bashrc bash_profile vimrc vim tmux.conf ssh gitconfig screenrc scss-lint.yml"
        ;;
    *)
        # Files for *nix
        echo "Preparing files for *nix"
				files="tern-config jshintrc ackrc inputrc zshrc bashrc bash_profile vimrc vim tmux.conf gitconfig screenrc profile scss-lint.yml"
        ;;
esac


##########
# create dotfiles_old in homedir
###
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

#########
# change to the dotfiles directory
###
echo "Changing to the $dir directory"
cd $dir || exit
echo "...done"

case $OSTYPE in
    msys|cygwin)
        # move any existing dotfiles in homedir to dotfiles_old directory, then copy dotfiles
        for file in $files; do
            echo "Moving existing $file from ~ to $olddir"
            [ -f "$HOME/.$file" ] && mv "$HOME/.$file" "$HOME/dotfiles_old/"
            echo "Creating copying to $file in home directory."
            cp -r "$dir/$file" "$HOME/.$file"
        done
        ;;
    *)
        # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
        for file in $files; do
            echo "Moving existing $file from ~ to $olddir"
            [ -f "$HOME/.$file" ] && mv "$HOME/.$file" "$HOME/dotfiles_old/"
            echo "Creating symlink to $file in home directory."
            ln -s "$dir/$file" "$HOME/.$file"
        done
        ;;
    esac

if [[ $files == *"ssh"* ]]; then
        cp "$HOME/dotfiles_old/.ssh/*" "$HOME/.ssh/"
fi

##########
# checkout submodules
###
git submodule init
git submodule update --recursive --remote

##########
# make fortunes
###
fortunes=$(cd "$dir/scripts/fortune" && make)
echo "$fortunes"

##########
# setup vim/vim-plug
###
echo "Attempting to install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Attempting to setup gist/vim-fist"
gem install gist && gist --login
echo "Installing vim plugins with Vundle"
vim +PlugInstall +qall

##########
# setup neovim/vim-plug
###

if type nvim >/dev/null 2>&1; then
  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
  ln -s "$dir/nvim" "$XDG_CONFIG_HOME/nvim"

  curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  nvim +PlugInstall +qall
fi

