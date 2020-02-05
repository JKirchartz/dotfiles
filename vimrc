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
Plug 'jkirchartz/vim-colors-megapack'
Plug 'jkirchartz/writegooder.vim' " 3 scripts to improve writing - wanna modify for other words/phrases to avoid


" Plugs
" Plug 'editorconfig/editorconfig-vim' " honor .editorconfig files
Plug 'sgur/vim-editorconfig' " honor .editorconfig files, in vimscript
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'ajh17/vim-fist'
Plug 'Valloric/MatchTagAlways'
" hail to the chief:
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' " a commit browser, requires fugitive
Plug 'tpope/vim-markdown', { 'for': 'md' }

"Plug 'romainl/vim-devdocs'

" Plug 'FooSoft/vim-argwrap'
Plug 'heavenshell/vim-jsdoc', { 'for': 'js' }

" snippets engine & library
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'aperezdc/vim-template'

" syntax completion, checking, & highlighting
Plug 'iloginow/vim-stylus'
Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tmux-plugins/vim-tmux'
" Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
" Plug 'dsawardekar/wordpress.vim', { 'for': 'php'}
if has('python') || has('python3')
  Plug 'maralla/completor.vim', { 'do': 'make js' }
else
  Plug 'ajh17/VimCompletesMe'
endif
Plug 'w0rp/ale'

" Vim Wiki
" Plug 'vimwiki/vimwiki'
Plug 'fcpg/vim-waikiki'

" use <leader>K(K|B|R|P) to access cheat.sh
Plug 'dbeniamine/cheat.sh-vim'

" vim included plugins
runtime macros/matchit.vim
runtime ftplugin/man.vim

" All of your Plugs must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

"}}}---------------------------------------------------------
" Plugin Settings
"------------------------------------------------------------ {{{
let wiki = {}
let wiki.path = "~/dotfiles/vimwiki/src/"
let wiki.path_html = "~/dotfiles/vimwiki/html/"
let wiki.template_path = "~/dotfiles/vim/templates/"
let wiki.template_default = "vimwiki"
let wiki.template_ext = ".html"
let wiki.auto_export = 1
let wiki.auto_toc = 1
let wiki.auto_tags = 1
let g:vimwiki_list = [wiki]

let g:waikiki_roots = ['~/dotfiles/vimwiki/']
let g:waikiki_wiki_patterns = ['/src/']
let maplocalleader = '\'
let g:waikiki_default_maps = 1


let g:ale_sign_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ ok']
let g:ale_sign_column_always = 1

" let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_linters={
      \ 'html': ['alex', 'htmlhint', 'proselint', 'stylelint', 'tidy', 'writegood', 'eslint', 'standard', 'xo', 'csslint', 'stylelint'],
      \ 'php': ['phpcs'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tsserver', 'eslint'],
      \ 'typescriptreact': ['tsserver', 'eslint'],
      \}
let g:ale_fixers = {
      \ 'html': ['tidy', 'prettier'],
      \ 'javascript': ['eslint', 'js-langserver'],
      \ 'typescript': ['eslint'],
      \ 'typescriptreact': ['eslint'],
      \ 'json': ['fixjson']
      \}
let g:ale_completion_tsserver_autoimport = 1 " automatic imports from external modules for typescript
let g:ale_php_phpcs_standard = 'Wordpress'
let g:ale_php_phpcs_use_global = 1
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%:%code%]' " show linter in messages/loclist


" don't fist anonymously, just privately
let g:fist_anonymously = 0
let g:fist_in_private = 1

" use _my_ info the default for vim-templates
let g:username = "jkirchartz"
let g:email = "me@jkirchartz.com"
let g:license = "NPL (Necessary Public License)"
let g:templates_directory = ["$HOME/.vim/templates"]


let hostname = substitute(system('hostname'), '\n', '', '')
if hostname =~ "aeo.ae"
  autocmd BufNewFile,BufReadPost *.* let g:templates_global_name_prefix = '=template='
  autocmd BufNewFile,BufReadPost *.html let g:templates_global_name_prefix = '=ae='
  autocmd BufNewFile,BufReadPost *.html setlocal indentexpr=GetJavascriptIndent()
endif

" tree-view
let g:netrw_liststyle = 3
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*' " use the previous window to open file
" open file in previous window
let g:netrw_browse_split = 4

" make EditorConfig play nice with vim-fugitive
" let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:editorconfig_blacklist = {
      \ 'filetype': ['git.*', 'fugitive'],
      \ 'pattern': ['\.un~$']}


if has('python') || has('python3')
  " use tab to select completion in completor.vim
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<cr>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  " set ultisnips directory
  set runtimepath+=~/.vim/LocalSnippets
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "LocalSnippets"]
endif


tnoremap <c-j> <C-W>

"}}}---------------------------------------------------------zo
" Vim Settings
"---------------------------------------------------------{{{
"
"map leader to space for world domination
nnoremap <Space> <Nop>
let mapleader = " "


set ffs=unix,mac,dos " Set default filetypes in descending wrongness
set clipboard^=unnamed,unnamedplus
set nobackup noswapfile " live dangerously
set lazyredraw " don't redraw screen while executing macros etc.
set hidden " allow unwritten buffers (unsaved files) to hide in the background
set number " show line number
set shortmess=atI " abbreviate or avoid certain messages
set noerrorbells " hear no evil
set novisualbell " see no evil
set list " show whitespace (using textmate-like symbols in the next line)
set listchars=conceal:×,tab:->,nbsp:∙,trail:•,extends:»,precedes:«,eol:¬
set smartcase " smart case matching
set hlsearch  " highlight search
set ignorecase " make /foo match FOO & FOo but /FOO only match FOO
" set mouse=a " enable mouse. how quaint.
set backspace=indent,eol,start " fix backspace(?)
" allow files to tell vim about themselves:
set modeline
set modelines=2

" better menu like for autocomplete
set wildmenu
set complete+=kspell
set completeopt+=menu,longest
set dictionary+=/usr/share/dict/words

" Tabs & Indents
set shiftround
" tabs are 2 columns wide, but are hard tabs
" set shiftwidth=2 tabstop=2
" tabs are 2 spaces
" set tabstop=2 expandtab
" tabs are 2 spaces... or else.
set shiftwidth=2 softtabstop=2 expandtab

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

" overwrite common misfires
command E e
command W w
command Q q
command Wq wq
command WQ wq
command Bn bn
cnoremap \<Enter> <Enter>

" faster Macro (at the expense of ex mode)
noremap Q @q

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

" silence command & redraw screen on end
command! -nargs=+ Silent
      \ execute 'silent <args>'
      \ | execute 'redraw!'

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

command! -bar Hitest :so $VIMRUNTIME/syntax/hitest.vim

" Calls to fun#... have functions in ~/.vim/autoload/fun.vim
command -bar Bs call fun#ScratchBuffer()
command -bar Sb call fun#ScratchBuffer()
command -bar Scratch call fun#ScratchBuffer()


" get image sizes

command -bar ImageSize call fun#ImageSize()

" easy access undotree
nmap <leader>ut :UndotreeToggle<CR>

" Replace the selected text with the base64 decoded version.
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

" Send the selected text to pastebin.
" TODO - automate putting the resulting uri on the clipboard, or
" at least opening it in a browser.
vnoremap cb <esc>:'<,'>:w !curl -F 'clbin=<-' https://clbin.com<CR>

" Send the selected text to vpaste ala ~/dotfiles/scripts/vpaste
map vp :exec "w !vpaste ft=".&ft<CR>
vmap vp <ESC>:exec "'<,'>w !vpaste ft=".&ft<CR>

" Make NetRW work more like NerdTree
" map <leader>t :call fun#ToggleVExplorer()<CR>
map <leader>t <ESC>:Lexplore<CR>
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize=25
let g:netrw_liststyle=3
" Change directory to the current buffer when opening files.
" set autochdir

" Easier navigation for ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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
nmap <leader>h :call fun#ToggleHex()<CR>

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


" reflow text using `par` command
map <leader>f {v}!par -jw80

if has('mac')
  " copy file to osx clipboard
  map <silent> <leader>cc :Silent !pbcopy < %<cr>
  vnoremap <silent> <leader>cc :Silent <esc>:'<,'>:w !pbcopy<cr>
endif


"}}}---------------------------------------------------------
" Function Keys
"---------------------------------------------------------{{{

" No Help, please (F1)
nmap <F1> <Esc>
imap <F1> <Esc>

" paste mode toggle (F2)
set pastetoggle=<F2>

" refresh current document
imap <F5> :e %<CR>
nmap <F5> :e %<CR>

" spell check toggle (F7)
imap <silent> <F7> :set spell!<cr>
nmap <silent> <F7> :set spell!<cr>

" borrowed from: https://github.com/mgedmin/dotvim/blob/master/vimrc#L1209
" <F8> = highlight identifier under cursor
" (some file-type dependent autocommands redefine it)
map             <F8>            :let @/='\<'.expand('<cword>').'\>'<bar>set hls<CR>
imap            <F8>            <C-O><F8>

" toggle through preset list of colorschemes (F7)
let g:colorSchemes = ["candycode", "darkblack", "molokai", "molokai_dark", "default"]
nnoremap <F9> :call fun#ColorSchemeToggle()<cr>

"}}}-----------------------------------------------------
" Autocmds
"-------------------------------------------------------{{{
if has("autocmd")
  " Use correct indenting for python
  autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
  " Jump to last position when reopening files
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
  " Set title to filename (or something IDK, it's been off for a while)
  "au BufEnter * let &titlestring = ' ' . expand("%:t")
  " ensure background is transparent
  autocmd ColorScheme * call fun#FixHighlights()
  autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown
  " trim trailing spaces (not tabs) before write
  autocmd BufWritePre * silent! %s:\(\S*\) \+$:\1:
  " a safer alternative to `set autochdir`
  " autocmd BufEnter * silent! lcd %:p:h
  " if a file starts with a shebang, automatically make it executable
  au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
endif


if has('gui_macvim')
  set macligatures
  set guifont=Fira\ Code:h12
endif

"}}}---------------------------------------------------
" set colorscheme
"----------------------------------------------------{{{

colorscheme molokai

function! Concealer()
  syntax match Equals "===" conceal cchar=≡
  syntax match NotEquals "!==" conceal cchar=≠
  syntax match GreaterThan ">=" conceal cchar=≥
  syntax match LessThan "<=" conceal cchar=≤
  hi! link Conceal Equals
  hi! link Conceal NotEquals
  hi! link Conceal GreaterThan
  hi! link Conceal LessThan
  setlocal conceallevel=1
endfunction

autocmd Syntax * call Concealer()

" fold up this file
" vim: foldmethod=marker
