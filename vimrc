"------------------------------------------------------------
" load external files/scripts/plugins
"---------------------------------------------------------{{{

" Vundle plugins
source ~/dotfiles/vundle.vimrc

" a standard set of tweaks:
source ~/dotfiles/lite.vimrc

" work-specific config
if filereadable(expand("~/at_google.vimrc"))
    source ~/at_google.vimrc
endif

" matchit
source $VIMRUNTIME/macros/matchit.vim

"}}}---------------------------------------------------------
" Custom Functions/Commands
"---------------------------------------------------------{{{

" forgot to sudo vi? w!!
cmap w!! %!sudo tee > /dev/null %

command! -bar DeleteTrailingSpaces :silent! %s:\(\S*\) \+$:\1:
command! -bar DeleteTrailingSpacesThenWrite :DeleteTrailingSpaces | :write
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

" write quickly
nmap <leader>w :w!<cr>
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


" cleanup & write quickly
nmap <leader><leader> :DeleteTrailingSpacesThenWrite<CR>
imap <leader><leader> <esc>:DeleteTrailingSpacesThenWrite<CR>

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

" delete all trailing whitespace (F4)
nmap <silent><F4> :DeleteTrailingSpaces<CR>
imap <silent><F4> :DeleteTrailingSpaces<CR>

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

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" make YCM ignore c/c++, coz that's not my bag
let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['gjslint','jshint']
" use pretty syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" don't fist anonymously, just privately
let g:fist_anonymously = 0
let g:fist_in_private = 1

" search files & buffers
let g:ctrlp_cmd = 'CtrlPMixed'
" make ctrlp faster
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn\|\.git5_specs$\|review$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
  \ 'link': 'READONLY$',
  \ }
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" use _my_ software license as the default for vim-templates
" let g:license = "NPL (Necessary Public License)"
let g:templates_directory = ["~/.vim/templates"]


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
endif

