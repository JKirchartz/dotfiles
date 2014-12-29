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

" Colorscheme
Plugin 'flazz/vim-colorschemes'

" Plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'Valloric/MatchTagAlways'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

" syntax completion, checking, & highlighting
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'

" snippets engine & library
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------
" Standard Tweaks
"------------------------------------------------------------
set nocompatible " work like VIM dammit! MUST be first!
set magic " NEVER TURN THIS OFF! WIZARDS WILL GET YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set encoding=utf-8 " ensure encoding
set clipboard=unnamed
set history=200 nobackup noswapfile " live dangerously
set nowrap backspace=indent,eol,start " fix backspace
set number ruler " show line number & cursor positition
set wildmenu  " better autocomplete
set showmode
set showcmd
set autoread " Set to auto read when a file is changed from the outside

"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "

" write quickly
nmap <leader>w :w!<cr> 

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fix windows ^M characters when encodings mess up ala http://amix.dk/vim/vimrc.html
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"------------------------------------------------------------
" Tell Text's Title to Terminal/Tmux
"------------------------------------------------------------
set title
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")


"------------------------------------------------------------
" Setup Colors
"------------------------------------------------------------
colorscheme molokai
"set background=dark
syntax on " highlight that syntax, please
" force 256 colors
"set t_Co=256

"------------------------------------------------------------
" Whitespace & Ln numbers
"------------------------------------------------------------
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬ " same symbols as TextMate
set list
nmap <leader>l :set list!<CR> " toggle whitespace
function! NumberToggle()
  if &relativenumber == 1
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc
function! NumberOff()
    set norelativenumber
    set nonumber
endfunc
nmap <leader>n :call NumberToggle()<CR> " toggle relative numbers
nmap <leader>nn :call NumberOff()<CR> " toggle relative numbers


"------------------------------------------------------------
" Search & Highlighting
"------------------------------------------------------------
set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO
nmap <leader><cr> :nohlsearch<CR> " clear search highlight


"------------------------------------------------------------
" Tabs & Indents
" All tabs are replaced by 4 spaces (Yes I'm *that* guy)
"------------------------------------------------------------
filetype plugin indent on
set autoindent
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


set colorcolumn=81
highlight ColorColumn ctermbg=Black

" highlight css in html(?)
let html_use_css=1

if has("autocmd")
      " Jump to last position when reopening files
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif
endif

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=

nnoremap <leader><leader> :DeleteTrailingWhitespace<CR>

" overwrite common misfires
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn

"------------------------------------------------------------
" Plugin Options
"------------------------------------------------------------
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDChristmasTree=1    " more colorful NERDTree
" close VIM 'normally' if NERDTree is running
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" make YCM ignore c/c++, coz that's not my bag
let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"------------------------------------------------------------
" Function Keys
"------------------------------------------------------------

" No Help, please (F1)
nmap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:
nnoremap <silent><F4> :DeleteTrailingWhitespace<CR>

" spell check toggle (F7)
inoremap <silent> <F7> <c -O>:call SpellToggle()<cr>
map <silent> <F7> :call SpellToggle()<cr>
map <leader>s :call SpellToggle()<cr>
function SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell
    endif
endfunction



"------------------------------------------------------------
" Improved Hex Editing
" http://vim.wikia.com/wiki/Improved_hex_editing
"------------------------------------------------------------

nmap <leader>h :Hexmode<CR> " toggle Hexmode

command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

