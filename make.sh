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
        files="inputrc bashrc bash_profile vimrc vim tmux.conf slate ssh gitconfig screenrc"
        ;;
    msys|cygwin)
        # Files for cygwin & msys
        echo "Preparing files for *doze"
        files="inputrc bashrc bash_profile vimrc vim tmux.conf ssh gitconfig screenrc"
        ;;
    *)
        # Files for *nix
        echo "Preparing files for *nix"
        files="inputrc bashrc bash_profile vimrc vim tmux.conf ssh gitconfig screenrc profile"
        ;;
esac

##########
# setup & get all git submodules
###
echo "Getting all git submodules"
git submodule init
git submodule update

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
cd $dir
echo "...done"

case $OSTYPE in
    msys|cygwin)
        # move any existing dotfiles in homedir to dotfiles_old directory, then copy dotfiles 
        for file in $files; do
            echo "Moving existing $file from ~ to $olddir"
            [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
            echo "Creating copying to $file in home directory."
            cp -r $dir/$file ~/.$file
        done
        ;;
    *)
        # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
        for file in $files; do
            echo "Moving existing $file from ~ to $olddir"
            [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
            echo "Creating symlink to $file in home directory."
            ln -s $dir/$file ~/.$file
        done
        ;;
    esac

echo
echo "if vim plugins etc fail to load, try running \"git submodule update\" to download the missing files, or run make.sh again."
