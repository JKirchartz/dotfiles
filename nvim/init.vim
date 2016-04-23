" Plug setup (with junegunn/vim-plug)
"---------------------------------------------------------{{{
call plug#begin()

" personal forks
Plug 'jkirchartz/vim-colorschemes' " forked flazz's, not sure enough about licenses to send a PR
Plug 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid

" Plugs
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on' : 'NerdTreeToggle' }
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'ervandew/supertab'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'ajh17/vim-fist'
Plug 'junegunn/fzf', {'dir' : '~/.fzf', 'do ': './install --all' }
Plug 'junegunn/fzf.vim'

" syntax completion, checking, & highlighting
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'lukaszb/vim-web-indent'
Plug 'heavenshell/vim-jsdoc'

" snippets engine & library
Plug 'Shougo/neosnippet' | Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'aperezdc/vim-template'

" All of your Plugs must be added before the following line
call plug#end()            " required


"}}}---------------------------------------------------------
" standard vim tweaks
"---------------------------------------------------------{{{
set magic " IF YOU TURN THIS ON, REGEX WIZARDS CAN SEE YOU!
set ffs=unix,dos,mac " Use *nix as the default file type
set nobackup noswapfile " live dangerously
set shortmess=atI " abbreviate or avoid certain messages
set scrolloff=3 " keep 3 lines between cursor and the edge of the screen

set title
let &titleold=getcwd() " stop flying the friendly skies
set shortmess=atI " abbreviate or avoid certain messages
set noerrorbells " hear no evil
set novisualbell " see no evil

set list " show whitespace (using symbols in the next line)

set smartcase " smart case matching
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO


" Tabs & Indents
filetype plugin indent on
set shiftround
" tabs are 2 spaces... or else.
set shiftwidth=2 softtabstop=2 expandtab

" 80 columns
set nowrap " don't soft-wrap
" set formatoptions+=tw " do hard-wrap
set textwidth=80 " be 80 wide
set wrapmargin=4 " wrap at 78
set colorcolumn=80 " show me what's TOO far

if has('persistent_undo')
  " save undos, so you can actually close vim without erasing the undo tree!
  set undodir=/tmp/nvim_undo
  set undofile
endif

" highlight css in html(?)
let html_use_css=1

" Setup colors/theme
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

"}}}---------------------------------------------------------
" Custom Functions/Commands
"---------------------------------------------------------{{{

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

command! -bar Hitest :so $VIMRUNTIME/syntax/hitest.vim

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

function ScratchBuffer()
  exe ':new'
  exe ':setlocal buftype=nofile'
  exe ':setlocal bufhidden=hide'
  exe ':setlocal noswapfile'
endfunc
command -bar Bs call ScratchBuffer()

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
command -bar Hexmode call ToggleHex()

"}}}---------------------------------------------------------
" Leader
"---------------------------------------------------------{{{
"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "

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
nmap <leader>n :call NumberToggle()<CR>

nmap <leader>pr :set list! nonumber norelativenumber<CR>

" clear search highlight
nmap <leader><cr> :nohlsearch<CR>

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=


" write quickly (autocmd deletes trailing spaces (not tabs))
nmap <leader><leader> :w<CR>
imap <leader><leader> <esc>:w<CR>

map <leader>s :spell!<cr>

map <leader>r :e %<cr>

" stop cycling when you can fly
nmap <leader>b :ls<CR>:b<space>

" fix this later: it should convert a line whose sole content is a URL to a link
nmap <leader>ll %s@^\%(ht\|f\)tps\?://\(\S\+\)@<a href="&">\1</a>@g
" :%s@\v^((ht<bar>f)tps?://)(\S+)@\<a href=\"\1\2\"\>\2\</a\>@g<cr>


"}}}---------------------------------------------------------
" Function Keys
"---------------------------------------------------------{{{

" No Help, please (F1)
nmap <F1> <Esc>
imap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" spell check toggle (F7)
imap <silent> <F7> :spell!<cr>
nmap <silent> <F7> :spell!<cr>

"}}}---------------------------------------------------------
" Plugin Options
"---------------------------------------------------------{{{

nmap <leader>u :UndotreeToggle<CR>

nmap <leader>t :NERDTreeToggle<CR>
let g:NERDChristmasTree=1    " more colorful NERDTree
" close VIM 'normally' if NERDTree is running
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&
                      \b:NERDTreeType == "primary") | q | endif

" add space to beginning of comments
let g:NERDSpaceDelims = 1

let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
if has("autocmd")
    autocmd FileType javascript.js let g:syntastic_javascript_checkers = ['gjslint','jshint']
    autocmd FileType javascript.jsx let g:syntastic_javascript_checkers = ['eslint']
else
    let g:syntastic_javascript_checkers = ['gjslint','jshint']
endif
let g:syntastic_ruby = ['rubocop','mri']
" use pretty syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" don't fist anonymously, just privately
let g:fist_anonymously = 0
let g:fist_in_private = 1

nmap <C-P> :FZF<CR>

" use _my_ software license as the default for vim-templates
let g:license = "NPL (Necessary Public License)"
let g:templates_directory = ["~/.vim/templates"]

" Shougo plugins
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = '$XDG_CONFIG_HOME/nvim/plugged/vim-snippets/snippets'
let g:deoplete#enable_at_startup = 1



"}}}-----------------------------------------------------
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
      " ensure background is transparent
      autocmd ColorScheme * highlight Normal ctermbg=None
      autocmd ColorScheme * highlight NonText ctermbg=None
      autocmd BufNewFile,BufReadPost *.md set filetype=markdown
      " trim trailing spaces (not tabs) before write
      autocmd BufWritePre * silent! %s:\(\S*\) \+$:\1:
endif

