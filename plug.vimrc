"------------------------------------------------------------
" Plug setup (with junegunn/vim-plug)
"------------------------------------------------------------
set nocompatible              " be iMproved
filetype off                  " required for vundle init

call plug#begin('~/.vim/plugged/')

" personal forks/projects
Plug 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plug 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid

Plug 'editorconfig/editorconfig-vim' " honor .editorconfig files
"play nice with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Plugs
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree' { 'on' : 'NERDTreeToggle' }
Plug 'mbbill/undotree' { 'on' : 'UndotreeToggle' }
Plug 'ervandew/supertab'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
" Plug 'ajh17/vim-fist'


" fuxxy file/buffer/mru/tag finder
Plug 'ctrlpvim/ctrlp.vim'

" syntax completion, checking, & highlighting
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/syntastic'

" python
Plug 'mitsuhiko/vim-python-combined'

" Javascript
Plug 'othree/yajs.vim'

" python
Plug 'davidhalter/jedi'

" php
Plug 'StanAngeloff/php.vim'
Plug 'shawncplus/phpcomplete.vim'

" wordpress
Plug 'dsawardekar/wordpress.vim'

" general web dev
Plug 'tpope/vim-markdown'
Plug 'tyru/open-browser.vim'


Plug 'lukaszb/vim-web-indent'
Plug 'heavenshell/vim-jsdoc'
Plug 'FooSoft/vim-argwrap'

" snippets engine & library
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'aperezdc/vim-template'

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

