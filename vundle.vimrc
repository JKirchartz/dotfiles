"------------------------------------------------------------
" Plugin setup (with Vundle)
"------------------------------------------------------------
set nocompatible              " be iMproved
filetype off                  " required for vundle init

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" personal forks
Plugin 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plugin 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid

" Plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'mbbill/undotree'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'Valloric/MatchTagAlways'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'ajh17/vim-fist'

" syntax completion, checking, & highlighting
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/syntastic'
Plugin 'lukaszb/vim-web-indent'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'FooSoft/vim-argwrap'


" wordpress.vim
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'dsawardekar/wordpress.vim'

" snippets engine & library
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'aperezdc/vim-template'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

