#!/bin/bash
############################
# .make.sh
# On *nix this script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Cygwin/msys will have ~/dotfiles copied into the home directory
# this is basically a dumber replacement for GNU stow... go figure
############################

dir=$HOME/dotfiles                    # dotfiles directory
olddir=$HOME/dotfiles_old             # old dotfiles backup directory

# this is a list of files that need moved to the home directory, but maybe a blacklist would be better?
files="bashrc bash_profile profile profile ssh jshintrc eslint.json"

##########
# checkout submodules (the recursiveneess should setup vim/etc for us, too!
###
git submodule init
git submodule update --recursive --remote

##########
# make fortunes
###
fortunes=$(cd "$dir/share/fortunes" && make)
echo "$fortunes"

##########
# setup vim/vim-plug (this is be managed by my vimrc repo now)
###
# echo "Attempting to install vim-plug"
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# if type gem >/dev/null 2>&1; then
#   echo "Attempting to setup gist/vim-fist"
#   gem install gist && gist --login
# fi
# echo "Installing vim plugins with Plug"
# vim +PlugInstall +qall

##########
# setup neovim/vim-plug (I'm not currently playing with neovim, or vim-plug)
###
# 
# if type nvim >/dev/null 2>&1; then
#   mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
#   ln -s "$dir/nvim" "$XDG_CONFIG_HOME/nvim"
# 
#   curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# 
#   nvim +PlugInstall +qall
# fi

##########
# setup zsh (Again, not using this much)
###
# 
# if type zsh >/dev/null 2>&1; then
#   echo "Attempting to install zplug"
#   curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
#   echo "Installing zsh plugins via ZPlug"
#   zplug install
# fi


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

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving existing $file from ~ to $olddir"
    [ -f "$HOME/.$file" ] && mv "$HOME/.$file" "$HOME/dotfiles_old/"
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/.$file"
done

# now lets do the same thing for folders in the ./config/ directory
for file in ./config/*/; do
    echo "Moving existing $file from ~/.config to $olddir"
    [ -f "$file" ] && mv "$file" "$HOME/dotfiles_old/"
    echo "Creating symlink from $file to $dir/$file"
    # TODO: uncomment last line after this check...
    # ln -s "$file" "$dir/$file"
done

if [[ $files == *"ssh"* ]]; then
        cp "$HOME/dotfiles_old/.ssh/*" "$HOME/.ssh/"
fi

