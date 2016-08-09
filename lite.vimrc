set nocompatible " be iMproved
set magic " IF YOU TURN THIS ON, REGEX WIZARDS CAN SEE YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set clipboard^=unnamed,unnamedplus
set nobackup noswapfile " live dangerously
set hidden " allow unwritten buffers (unsaved files) to hide in the background
set number " show line number
set shortmess=atI " abbreviate or avoid certain messages

"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "

" better menu like for autocomplete
set wildmenu
set completeopt=menu,longest

set title
let &titleold=getcwd() " stop telling me I'm flying the friendly skies
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
" try a couple, see which sticks
silent! colorscheme elflord
silent! colorscheme smyck
silent! colorscheme apprentice
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

" Avoid the esc key
inoremap <silent> <Up> <ESC>k
inoremap <silent> <Down> <ESC>j
inoremap <silent> <Left> <ESC>h
inoremap <silent> <Right> <ESC>l
imap hj <esc>
imap jh <esc>


" vim included plugins
source $VIMRUNTIME/macros/matchit.vim
source $VIMRUNTIME/ftplugin/man.vim

" keep man in vim, replicate built-in functionality
nnoremap K :Man <C-R>=expand("<cword>")<cr><cr>



