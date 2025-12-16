#!/bin/sh
############################
# install.sh
# this is basically a dumber replacement for GNU stow... go figure
# I didn't really like stow or any of the alternatives, so I'm just getting the files I want how I want.
############################
PS4=">_> "                  # just for the looks... <_<
set -o xtrace               # show everything as it happens ... except for the stuff above this line...

dir="$HOME/dotfiles"        # dotfiles directory
olddir="$HOME/dotfiles_old" # old dotfiles backup directory

#########
# we should be here, but maybe for some reason I might not be? IDK
###
cd "$dir" || exit

##########
# checkout submodules; the recursiveneess will setup vim, fortunes, etc
###
git submodule init
git submodule update --recursive --remote

##########
# make fortunes
###
# probably a smarter way to do this with submodules/subshells but w/e
cd "$dir/share/fortunes" && make

#########
# ok, now we definitely should maybe need to go back to here...
###
cd "$dir" || exit

# move any existing dotfiles in $HOME to dotfiles_old directory, then create symlinks
for f in $(git ls-files home/ | sort -u); do
    echo "working on $f..."
    file=$(basename "$f")
    # if it's a file and not a link, back it up
    [ -f "$HOME/.$file" ] && [ ! -L "$HOME/.$file" ] && mv "$HOME/.$file" "$olddir"
    # if it's not a file or a link, it's probably broken
    rm -rf "$HOME/.$file"
    ln -s "${dir}/${f}" "$HOME/.$file"
done

# now lets do the same thing for files in the ./config/ directory
# git ls-files doesn't list the contents of submodules
# so some directories will be symlinked directly. (the way I want it. :P)
for file in $(git ls-files config/ | sort -u); do
    echo "working on $file..."
    filedir=$(dirname "$file")
    # if the filedir is config we want the file to link directly
    [ "$filedir" = "config" ] && filedir="$file"
    [ ! -d "$HOME/.$filedir" ] && mkdir -p "$HOME/.$filedir"
    [ -f "$HOME/.$file" ] && [ ! -L "$HOME/.$file" ] && mv "$HOME/.$file" "$olddir"
    rm -rf "$HOME/.$file"
    ln -s "${dir}/${file}" "$HOME/.$file"
done

# aaand skootch over this thang
[ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
[ ! -f "$HOME/.ssh/config" ] && ln -s "$dir/ssh/config" "$HOME/.ssh/config"

