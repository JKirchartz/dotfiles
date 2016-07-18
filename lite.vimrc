set nocompatible " be iMproved
set magic " IF YOU TURN THIS ON, REGEX WIZARDS CAN SEE YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set encoding=utf-8 " ensure encoding
set clipboard^=unnamed,unnamedplus
set history=200 nobackup noswapfile " live dangerously
set backspace=indent,eol,start " fix backspace
set number " show line number
set wildmenu  " better menu like for autocomplete
set shortmess=atI " abbreviate or avoid certain messages
set scrolloff=3 " keep 3 lines between cursor and the edge of the screen

set title
let &titleold=getcwd() " stop flying the friendly skies
set shortmess=atI " abbreviate or avoid certain messages
set noerrorbells " hear no evil
set novisualbell " see no evil

set list " show whitespace (using symbols in the next line)
" use textmate-like symbols
set listchars=tab:▶-,nbsp:܁,trail:•,extends:»,precedes:«,eol:¬

set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO

set mouse=a " enable mouse. how quaint.

" Tabs & Indents
filetype plugin indent on
set autoindent
set shiftround
" tabs are 2 spaces... or else.
set shiftwidth=2 softtabstop=2 expandtab

" 80 columns
set nowrap " don't soft-wrap
set formatoptions+=tw " do hard-wrap
set textwidth=80 " be 80 wide
set wrapmargin=4 " wrap at 78
set colorcolumn=80 " show me what's TOO far

if has('persistent_undo')
  " save undos, so you can actually close vim without erasing the undo tree!
  silent call system('mkdir -p /tmp/vim_undo')
  set undodir=/tmp/vim_undo
  set undofile
endif

" highlight css in html(?)
let html_use_css=1

" Setup colors/theme
set laststatus=2 " see the last statusline(stl)
set showmode showcmd " show modes & commands in stl
" show cursor position (like :set ruler) & git status in statusline
set statusline=\ b%n\ %<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
colorscheme smyck
syntax on " highlight that syntax, please
" highlight StatusLine cterm=NONE ctermbg=0 ctermfg=10
" highlight ColorColumn cterm=NONE ctermbg=0


" overwrite common misfires
command E e
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn
cnoremap \<Enter> <Enter>

" avoid esc key (and retrain brain I'm no longer remapping capslock)
" Avoid the esc key
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>
inoremap <silent> <Left> <ESC><Left>
inoremap <silent> <Right> <ESC><Right>
imap hj <esc>
imap jh <esc>


" vim included plugins
source $VIMRUNTIME/macros/matchit.vim
source $VIMRUNTIME/ftplugin/man.vim

" keep man in vim, replicate built-in functionality
nnoremap K :Man <C-R>=expand("<cword>")<cr><cr>



