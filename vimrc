set  nocompatible " work like VIM dammit! MUST be first!
set magic " NEVER TURN THIS OFF! BAD MOJO!
set encoding=utf-8 " utf-8 paranoia

let mapleader="," " backslash is to far away :(
syntax on " highlight that syntax, please
filetype plugin indent on
set clipboard=unnamed

" pathogen
call pathogen#infect()
call pathogen#helptags()

" Security fix: modelines have been an avenue for trojan attacks against
" VIM-users, so we'll disable that.
set nomodeline

" set terminal title
set title

" setup colors
colorscheme solarized
if has('gui_running')
    set background=light
else
    set background=dark
endif
" degrade to 256 color if solarized isn't your TERM colors
" set t_Co=256
" let g:solarized_termcolors=256
let g:solarized_visibility="high" " highlight trailing spaces etc from list

set list " show trailing spaces, tabs etc
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs
nmap <leader>l :set list!<CR> " Shortcut to rapidly toggle `set list`

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
" ALWAYS FOUR SPACES. ALWAYS.
set smartindent
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" show line number & cursor positition
set number ruler

" 80 column rule
set colorcolumn=81
highlight ColorColumn ctermbg=Grey

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

" No Help, please (F1)
nmap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" autocomplete (F3)
imap <F3> <C-P>

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:
nnoremap <silent><F4> :DeleteTrailingWhitespace<CR>

"toggle solarized bg
call togglebg#map("<F5>")

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

" Calculator
" https://nixtricks.wordpress.com/2009/10/30/vim-simple-calculator-in-vim/
nnoremap c :echo string(eval(input("calc: ")))


" NerdTree
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDChristmasTree=1    " more colorful NERDTree
" close VIM "normally" if NERDTree is running
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

