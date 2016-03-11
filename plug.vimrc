"------------------------------------------------------------
" Plug setup (with Vundle)
"------------------------------------------------------------
set nocompatible              " be iMproved
filetype off                  " required for vundle init

call plug#begin('~/.vim/plugged/')

" personal forks
Plug 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plug 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid

" Plugs
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree' { 'on' : 'NerdTreeToggle' }
Plug 'ervandew/supertab'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'ajh17/vim-fist'


if isdirectory('~/.fzf')
  Plug 'junefunn/fzf', {'dir' : '~/.fzf', 'do ': './install --all' }
else
  Plug 'ctrlpvim/ctrlp'
endif

" syntax completion, checking, & highlighting
if hostname() != "triton" " don't bother on triton
  Plug 'Valloric/YouCompleteMe'
endif
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'lukaszb/vim-web-indent'
Plug 'heavenshell/vim-jsdoc'

" snippets engine & library
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

