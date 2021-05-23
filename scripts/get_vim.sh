#! /usr/bin/env bash
# adapted from https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

cd ~/projects
git clone --depth 1 https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --disable-gui \
            --enable-cscope \
            --prefix=/usr/local


vnum=$(git describe --tags | cut -d '.' -f -2 | sed 's/[^0-9]//g')
make VIMRUNTIMEDIR="/usr/local/share/vim/vim${vnum}"
sudo make install
