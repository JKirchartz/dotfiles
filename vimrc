" Plug setup (with junegunn/vim-plug)
"---------------------------------------------------------{{{

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

set nocompatible              " be iMproved
filetype off                  " required for vundle init

call plug#begin('~/.vim/plugged/')

" personal forks/projects
Plug 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plug 'jkirchartz/writegooder.vim', { 'for': ['md', 'txt', 'htm', 'html'] } " 3 scripts to improve writing - wanna modify for other words/phrases to avoid


" Plugs
Plug 'editorconfig/editorconfig-vim' " honor .editorconfig files
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'ajh17/vim-fist'
Plug 'Valloric/MatchTagAlways'
" hail to the chief:
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'md' }

" tmux conf stuff
Plug 'tmux-plugins/vim-tmux'

" Javascript
Plug 'othree/yajs.vim', { 'for': 'js' }

" python
Plug 'davidhalter/jedi', { 'for': 'py' }
Plug 'mitsuhiko/vim-python-combined', { 'for': 'py' }

" php
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }

" wordpress
Plug 'dsawardekar/wordpress.vim', { 'for': 'php'}

" general web dev
Plug 'othree/html5.vim'
" Plug 'tyru/open-browser.vim'
" Plug 'heavenshell/vim-jsdoc', { 'for': 'js' }
" Plug 'FooSoft/vim-argwrap'

" snippets engine & library
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'aperezdc/vim-template'

" syntax completion, checking, & highlighting
Plug 'ajh17/VimCompletesMe'
Plug 'scrooloose/syntastic'


" vim included plugins
runtime macros/matchit.vim
runtime ftplugin/man.vim

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

"}}}---------------------------------------------------------
" Plugin Settings
"------------------------------------------------------------ {{{

" tree-view
let g:netrw_liststyle = 3
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*' " use the previous window to open file
" open file in previous window
let g:netrw_browse_split = 4

" make EditorConfig play nice with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" fix ultisnips/vimcompletesme & allow <CR> to select entry
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardsTrigger = "<s-tab>"
let g:ulti_expand_or_jump_res = 0
inoremap <expr> <CR> pumvisible() ? "<C-R>=fun#ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
" set ultisnips directory
set runtimepath+=~/.vim/LocalSnippets
let g:UltiSnipsSnippetsDir=["UltiSnips", "LocalSnippets"]

"}}}---------------------------------------------------------zo
" Vim Settings
"---------------------------------------------------------{{{
"
"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "

set ffs=unix,mac,dos " Set default filetypes in descending wrongness
set clipboard^=unnamed
set nobackup noswapfile " live dangerously
set hidden " allow unwritten buffers (unsaved files) to hide in the background
set number " show line number
set shortmess=atI " abbreviate or avoid certain messages
set noerrorbells " hear no evil
set novisualbell " see no evil
set list " show whitespace (using textmate-like symbols in the next line)
set listchars=tab:>-,nbsp:•,trail:•,extends:»,precedes:«,eol:¬
set smartcase " smart case matching
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO
set mouse=a " enable mouse. how quaint.

" better menu like for autocomplete
set wildmenu
set complete+=kspell
set completeopt+=menu,longest
set dictionary+=/usr/share/dict/words

" Tabs & Indents
set shiftround
" tabs are be 2 spaces
set tabstop=2 expandtab
" tabs are 2 spaces... or else.
" set shiftwidth=2 softtabstop=2 expandtab

" 80 columns
set nowrap " don't soft-wrap
" set formatoptions+=tw " do hard-wrap
" set textwidth=80 " be 80 wide
" set wrapmargin=4 " wrap at 78
set colorcolumn=80 " show me what's TOO far

if has('persistent_undo')
	" save undos, so you can actually close vim without erasing the undo tree!
	silent call system('mkdir -p /tmp/vim_undo')
	set undodir=/tmp/vim_undo
	set undofile
endif

" use ack for grepping
set grepprg=ack\ -H\ --nocolor\ --nogroup

" Setup colors/theme
set laststatus=2 " see the last statusline(stl)
" show modes & commands in stl
set showmode
set showcmd
" show cursor position (like :set ruler) & git status in statusline
set statusline=\ b%n\ %<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
colorscheme candycode

" overwrite common misfires
command E e
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn
cnoremap \<Enter> <Enter>

" Avoid the esc key
inoremap <silent> <Up> <ESC>k
inoremap <silent> <Down> <ESC>j
inoremap <silent> <Left> <ESC>h
inoremap <silent> <Right> <ESC>l

" keep man in vim, replicate built-in functionality
" these two seem to be functionally identical, but some plugins may rewrite
" keywordprg, so maybe setl keywordprg=:Man might be in order...?
" nnoremap K :Man <C-R>=expand("<cword>")<cr><cr>
set keywordprg=:Man

if exists("syntax_on") || exists("syntax_manual")
else
	syntax on
endif

"}}}---------------------------------------------------------
" Custom Commands
"---------------------------------------------------------{{{

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

command! -bar Hitest :so $VIMRUNTIME/syntax/hitest.vim

" Calls to fun#... have functions in ~/.vim/autoload/fun.vim
command -bar Bs call fun#ScratchBuffer()
command -bar Scratch call fun#ScratchBuffer()

" Send the selected text to pastebin.
" TODO - automate putting the resulting uri on the clipboard, or
" at least opening it in a browser.
vnoremap <leader>pb <esc>:'<,'>:w !curl -F 'clbin=<-' https://clbin.com<CR>

" Make NetRW work more like NerdTree
map <leader>t :call fun#ToggleVExplorer()<CR>
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize=25
let g:netrw_liststyle=3
" Change directory to the current buffer when opening files.
" set autochdir

"}}}---------------------------------------------------------
" Leader
"---------------------------------------------------------{{{

" wq quickly
nmap <leader>q :wqall<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fix windows ^M characters when encodings mess up
" ( ala http://amix.dk/vim/vimrc.html )
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" toggle whitespace
nmap <leader>l :set list!<CR>

" toggle Hexmode
nmap <leader>h :Hexmode<CR>

"toggle number relativity
nmap <leader>n :call fun#NumberToggle()<CR>

nmap <leader>pr :set list! nonumber norelativenumber<CR>

" clear search highlight
nmap <leader><cr> :nohlsearch<CR>

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=

" write quickly (autocmd deletes trailing spaces (not tabs))
nmap <leader><leader> :w<CR>

" spell checking
map <leader>s :setlocal spell spelllang=en_us<cr>

map <leader>r :e %<cr>

" stop cycling when you can fly
nmap <leader>b :ls<CR>:b<space>


"}}}---------------------------------------------------------
" Function Keys
"---------------------------------------------------------{{{

" No Help, please (F1)
nmap <F1> <Esc>
imap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" spell check toggle (F7)
imap <silent> <F7> :set spell!<cr>
nmap <silent> <F7> :set spell!<cr>

"}}}---------------------------------------------------------
" Plugin Options
"---------------------------------------------------------{{{

nmap <leader>ut :UndotreeToggle<CR>

let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
if has("autocmd")
	autocmd FileType javascript.js let g:syntastic_javascript_checkers = ['gjslint', 'jshint']
	autocmd FileType javascript.jsx let g:syntastic_javascript_checkers = ['eslint']
endif
let g:syntastic_ruby = ['rubocop', 'mri']
let g:syntastic_php_phpcs_args='--standard=WordPress'
" use pretty syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" don't fist anonymously, just privately
let g:fist_anonymously = 0
let g:fist_in_private = 1

" use _my_ info the default for vim-templates
let g:username = "jkirchartz"
let g:email = "me@jkirchartz.com"
let g:license = "NPL (Necessary Public License)"
" let g:templates_directory = ["$HOME/.vim/templates"]


"}}}-----------------------------------------------------
" Autocmds
"-------------------------------------------------------{{{
if has("autocmd")
	" Use correct indenting for python
	autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
	" Jump to last position when reopening files
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal g'\"" | endif
	" Set title to filename (or something IDK, it's been off for a while)
	"au BufEnter * let &titlestring = ' ' . expand("%:t")
	" ensure background is transparent
	autocmd ColorScheme * highlight Normal ctermbg=None
	autocmd ColorScheme * highlight NonText ctermbg=None
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
	" trim trailing spaces (not tabs) before write
	autocmd BufWritePre * silent! %s:\(\S*\) \+$:\1:
endif


" fold up this file
" vim:foldmethod=marker
