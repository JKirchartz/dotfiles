"------------------------------------------------------------
" Setup Plugins
"---------------------------------------------------------{{{

if filereadable(expand("~/at_google.vimrc"))
    source ~/at_google.vimrc
else
    source ~/dotfiles/vundle.vimrc
endif

source $VIMRUNTIME/macros/matchit.vim

"}}}---------------------------------------------------------
" Standard Tweaks
"---------------------------------------------------------{{{
set nocompatible " be iMproved
set magic " NEVER TURN THIS OFF! WIZARDS WILL GET YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set encoding=utf-8 " ensure encoding
set clipboard=unnamed
set history=200 nobackup noswapfile " live dangerously
set backspace=indent,eol,start " fix backspace
set number ruler " show line number & cursor positition
set wildmenu  " better menu like for autocomplete
set showmode showcmd " show modes & commands down below
set autoread " Set to auto read when a file is changed from the outside
set shortmess=atI " abbreviate or avoid certain messages
set laststatus=2 " see the last status
set shell=/bin/bash\ -i " use interactive bash as the shell

set title
let &titleold=getcwd() " stop flying the friendly skies
set shortmess=atI " abbreviate or avoid certain messages
set noerrorbells " hear no evil
set novisualbell " see no evil

set list " show whitespace (using symbols in the next line)
set listchars=tab:▶-,trail:•,extends:»,precedes:«,eol:¬ " use textmate symbols

set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO

set mouse=a " enable mouse. how quaint.

" Tabs & Indents
filetype plugin indent on
set autoindent
set shiftround
" tabs are 4 spaces.
" set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" tabs are 2 spaces.
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" 80 columns
set nowrap " don't soft-wrap
set formatoptions+=w " do hard-wrap
set textwidth=80 " be 80 wide
set wrapmargin=2 " wrap at 78
set colorcolumn=81 " show me what's TOO far
highlight ColorColumn ctermbg=Black


" highlight css in html(?)
let html_use_css=1

" Setup Colors
colorscheme candy
syntax on " highlight that syntax, please

"}}}---------------------------------------------------------
" Custom Functions/Commands
"---------------------------------------------------------{{{

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

" overwrite common misfires
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn
cnoremap \<Enter> <Enter>

function! NumberToggle()
  if &relativenumber == 1 && &number == 1
    set norelativenumber
    set nonumber
  elseif &relativenumber == 0 && &number == 1
    set relativenumber
  else
    set number
  endif
endfunc

" Improve hex editing (ala http://vim.wikia.com/wiki/Improved_hex_editing)
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

command! DeleteTrailingWhitespace :silent! %s:\(\S*\)\s\+$:\1:
command -bar Hexmode call ToggleHex()

"}}}---------------------------------------------------------
" Leader
"---------------------------------------------------------{{{
"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "

" write quickly
nmap <leader>w :w!<cr>

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
nmap <leader>n :call NumberToggle()<CR>

nmap <leader>pr :set list! nonumber norelativenumber<CR>

" clear search highlight
nmap <leader><cr> :nohlsearch<CR>

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=

" cleanup & write quickly
nnoremap <leader><leader> :DeleteTrailingWhitespace<CR>:w!<CR>

map <leader>s :spell!<cr>

"}}}---------------------------------------------------------
" Function Keys
"---------------------------------------------------------{{{

" No Help, please (F1)
nmap <F1> <Esc>
imap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" delete all trailing whitespace (F4)
nmap <silent><F4> :DeleteTrailingWhitespace<CR>
imap <silent><F4> :DeleteTrailingWhitespace<CR>

" spell check toggle (F7)
imap <silent> <F7> :spell!<cr>
nmap <silent> <F7> :spell!<cr>

"}}}---------------------------------------------------------
" Plugin Options
"---------------------------------------------------------{{{
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDChristmasTree=1    " more colorful NERDTree
" close VIM 'normally' if NERDTree is running
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && 
b:NERDTreeType == "primary") | q | endif

" add space to beginning of comments
let g:NERDSpaceDelims = 1

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

nmap <leader>sc :SyntasticCheck<CR>
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['gjslint','jshint']
" use pretty syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" make ctrlp faster
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.git5_specs$\|review$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'READONLY$',
  \ }

" use _my_ software liscence as the default for vim-templates
let g:license = "NPL (Necessary Public Liscence)"

"}}}-------------------------------------------------------
" autocmds
"-------------------------------------------------------{{{
if has("autocmd")
      " fold up vim files
      autocmd FileType vim setlocal foldmethod=marker
      " Jump to last position when reopening files
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif
      " Set title to filename (or something IDK, it's been off for a while)
      "au BufEnter * let &titlestring = ' ' . expand("%:t")
endif
