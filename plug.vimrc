"------------------------------------------------------------
" Plug setup (with junegunn/vim-plug)
"------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set nocompatible              " be iMproved
filetype off                  " required for vundle init

call plug#begin('~/.vim/plugged/')

" personal forks/projects
Plug 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plug 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid


" Plugs
" Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'editorconfig/editorconfig-vim' " honor .editorconfig files
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'ervandew/supertab'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'ajh17/vim-fist'


" Javascript
Plug 'othree/yajs.vim'

" python
Plug 'davidhalter/jedi'
Plug 'mitsuhiko/vim-python-combined'

" php
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }

" wordpress
Plug 'dsawardekar/wordpress.vim', { 'for': 'php'}

" general web dev
Plug 'othree/html5.vim'
Plug 'tpope/vim-markdown'
Plug 'tyru/open-browser.vim'
Plug 'lukaszb/vim-web-indent'
Plug 'heavenshell/vim-jsdoc'
Plug 'FooSoft/vim-argwrap'

" snippets engine & library
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'aperezdc/vim-template'

" fuxxy file/buffer/mru/tag finder
Plug 'ctrlpvim/ctrlp.vim'

" syntax completion, checking, & highlighting
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/syntastic'



" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

" make EditorConfig play nice with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" replace NerdTree w/ netrw+vinegar
nmap <leader>t :Lex<CR>

" user vim-commentary like nerdcommenter
nmap <leader>cc gcc

" setup Neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Enable omni completion.
autocmd FileType php setlocal omnifunc=phpcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css,sass,less,scss setlocal omnifunc=csscomplete#CompleteCSS

