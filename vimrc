syntax on
filetype plugin indent on

set nocompatible " work like VIM dammit!
set magic " NEVER TURN THIS OFF!
set encoding=utf-8 " utf-8 paranoia

" colorscheme
set background=dark
"uncomment next line to use terminal with 256 color support
let g:solarized_termcolors=256
let g:solarized_visibility="high"
colorscheme solarized

if has('gui_running')
    set background=light
else
    set background=dark
endif

set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬

" live dangerously:
set history=100 nobackup noswapfile

" osx backspace fix
set nowrap backspace=indent,eol,start

set ffs=unix,dos,mac " Use Unix as the standard file type
set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set wildmenu  " better autocomplete for commands
set showmode
set showcmd

" tabs & indents
" All tabs are replaced by 4 spaces
set smartindent
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" show line number & cursor positition
set number ruler

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

" double tab for autocomplete
imap <Tab><Tab> <C-P>

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" paste mode toggle (F2)
set pastetoggle=<F2>

" spell check toggle (F5)
inoremap <silent> <F5> <c -O>:call SpellToggle()<cr>
map <silent> <F5> :call SpellToggle()<cr>
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

" http://vim.wikia.com/wiki/Improved_hex_editing
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

" Security fix: modelines have been an avenue for trojan attacks against
" VIM-users, so we'll disable that.
set nomodeline

" pathogen
call pathogen#infect()

