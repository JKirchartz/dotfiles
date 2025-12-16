#!/bin/bash
############################
# install.sh
# this is basically a dumber replacement for GNU stow... go figure
# I didn't really like stow or any of the alternatives, so I'm just getting the files I want how I want.
############################
PS4="\n\033[1;33m>_>\033[0m "        # just for the looks... <_<
set -o xtrace                         # show everything as it happens ... except for the stuff above this line...

dir="$HOME/dotfiles"                    # dotfiles directory
olddir="$HOME/dotfiles_old"             # old dotfiles backup directory

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

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for f in $(git ls-files home/ | sort -u); do
    echo "working on $f..."
    file=$(basename "$f")
    [ -f "$HOME/.$file" ] && mv "$HOME/.$file" "$olddir"
    ln -s "${dir}/home/${file}" "$HOME/.$file"
done

# now lets do the same thing for files in the ./config/ directory
# git ls-files doesn't list the contents of submodules
# so some directories will be symlinked directly. (the way I want it. :P)
for file in $(git ls-files config/ | sort -u); do
    echo "working on $file..."
    filedir=$(dirname "$file")
    [ ! -d "$HOME/.$filedir" ] && mkdir -p "$HOME/.$filedir"
    [ -f "$file" ] && mv "$file" "$olddir"
    ln -s "${dir}/${file}" ".$file"
done

# aaand skootch over this thang
[ ! -d "$HOME/.ssh" ] && mkdir "$HOME/.ssh"
[ ! -f "$HOME/.ssh/config" ] && ln -s "$dir/ssh/config" "$HOME/.ssh/config"

