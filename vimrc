"------------------------------------------------------------
" Standard Tweaks
"------------------------------------------------------------
set  nocompatible " work like VIM dammit! MUST be first!
set magic " NEVER TURN THIS OFF! WIZARDS WILL GET YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set encoding=utf-8 " ensure encoding
set nomodeline " Security fix: modelines have been an avenue for trojan attacks
syntax on " highlight that syntax, please
filetype plugin indent on
set clipboard=unnamed
set history=100 nobackup noswapfile " live dangerously
set nowrap backspace=indent,eol,start " fix backspace
set number ruler " show line number & cursor positition
set wildmenu  " better autocomplete
set showmode
set showcmd
nnoremap <Space> <Nop>
let mapleader = " "


"------------------------------------------------------------
" Set Terminal Title for Tmux
"------------------------------------------------------------
set title
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")


"------------------------------------------------------------
" Setup Colors
"------------------------------------------------------------
colorscheme molokai
"set background=dark
" force 256 colors
"set t_Co=256

"------------------------------------------------------------
" Show Whitespace
"------------------------------------------------------------
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬ " same symbols as TextMate
set list
nmap <leader>l :set list!<CR> " toggle whitespace


"------------------------------------------------------------
" Search & Highlighting
"------------------------------------------------------------
set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO
nmap <leader>q :nohlsearch<CR> " clear search highlight


"------------------------------------------------------------
" Tabs & Indents
" All tabs are replaced by 4 spaces (Yes I'm *that* guy)
"------------------------------------------------------------
set smartindent
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


"------------------------------------------------------------
" 80 column rule
"------------------------------------------------------------
set colorcolumn=81
highlight ColorColumn ctermbg=Black

" highlight css in html(?)
let html_use_css=1

if has("autocmd")
      " Jump to last position when reopening files
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif

      " liquid highlighting
      au BufNewFile,BufRead *.liquid   setf liquid

      "enable omnicomplete
      autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
endif

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=

"------------------------------------------------------------
" Function Keys


"------------------------------------------------------------

" No Help, please (F1)
nmap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" autocomplete (F3)
imap <F3> <C-P>

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:
nnoremap <silent><F4> :DeleteTrailingWhitespace<CR>

" spell check toggle (F7)
inoremap <silent> <F7> <c -O>:call SpellToggle()<cr>
map <silent> <F7> :call SpellToggle()<cr>
function SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell
    endif
endfunction

" overwrite common misfires
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn


"------------------------------------------------------------
" Improved Hex Editing
" http://vim.wikia.com/wiki/Improved_hex_editing
"------------------------------------------------------------
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

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

"------------------------------------------------------------
" pathogen
"------------------------------------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
set pathogen#infect()
set pathogen#helptags()

"------------------------------------------------------------
" NerdTree
"------------------------------------------------------------
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDChristmasTree=1    " more colorful NERDTree
" close VIM "normally" if NERDTree is running
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

