set nocompatible " work like VIM dammit!
set magic " NEVER TURN THIS OFF!


" live dangerously:
set history=100
set nobackup
set noswapfile

"utf-8 paranoia
:set encoding=utf-8

" osx backspace fix
set backspace=indent,eol,start
set nowrap

" Use Unix as the standard file type
set ffs=unix,dos,mac

set smartcase " smart case matching
set incsearch " incremental search
set hlsearch  " highlight search
set showmode
set showcmd

set mouse=a   " my mouse is bored, lemme use it occasionally.
set mousehide " don't show the mouse while typing.
set wildmenu  " better autocomplete for commands

syntax on
filetype plugin indent on

" colorscheme
colorscheme solarized
if has('gui_running')
	set background=light
else
	set background=dark
endif

let html_use_css=1

" tabs & indents
set autoindent         " Use indent from previous line
set smarttab           " Smart handling of the tab key
set expandtab          " Use spaces for tabs
set shiftround         " Round indent to multiple of shiftwidth
set shiftwidth=4       " Number of spaces for each indent
set softtabstop=4      " Number of spaces for tab key
set backspace=2        " Allow backspacing over indent, eol, start

" show line number & cursor positition
set number
set ruler

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

imap <Tab><Tab> <C-P>

" paste while keeping the current indent
nnoremap <leader>p p`[v`]=


" overwrite common misfires
command W w
command Q q
command Wq wq
command WQ wq

" Security fix: modelines have been an avenue for trojan attacks against
" VIM-users, so we'll disable that.
set nomodeline
