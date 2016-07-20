version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <S-Tab> <Plug>SuperTabBackward
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
inoremap <silent> <Plug>NERDCommenterInsert  <BS>:call NERDComment('i', "insert")
imap <silent> <F7> :set spell!
imap <F1> 
inoremap <silent> <Right> <Right>
inoremap <silent> <Left> <Left>
inoremap <silent> <Down> <Down>
inoremap <silent> <Up> <Up>
snoremap <silent>  c
map  <Plug>(ctrlp)
snoremap  "_c
xmap  u <Plug>fov_visual_update
nmap  u <Plug>fov_update
xmap  p <Plug>fov_visual_new
nmap  ca <Plug>NERDCommenterAltDelims
xmap  cu <Plug>NERDCommenterUncomment
nmap  cu <Plug>NERDCommenterUncomment
xmap  cb <Plug>NERDCommenterAlignBoth
nmap  cb <Plug>NERDCommenterAlignBoth
xmap  cl <Plug>NERDCommenterAlignLeft
nmap  cl <Plug>NERDCommenterAlignLeft
nmap  cA <Plug>NERDCommenterAppend
xmap  cy <Plug>NERDCommenterYank
nmap  cy <Plug>NERDCommenterYank
xmap  cs <Plug>NERDCommenterSexy
nmap  cs <Plug>NERDCommenterSexy
xmap  ci <Plug>NERDCommenterInvert
nmap  ci <Plug>NERDCommenterInvert
nmap  c$ <Plug>NERDCommenterToEOL
xmap  cn <Plug>NERDCommenterNested
nmap  cn <Plug>NERDCommenterNested
xmap  cm <Plug>NERDCommenterMinimal
nmap  cm <Plug>NERDCommenterMinimal
xmap  c  <Plug>NERDCommenterToggle
nmap  c  <Plug>NERDCommenterToggle
xmap  cc <Plug>NERDCommenterComment
nmap  cc <Plug>NERDCommenterComment
nmap  wg :WritegooderToggle
map  rwp <Plug>RestoreWinPosn
map  swp <Plug>SaveWinPosn
map  Htd <Plug>AM_Htd
nmap  t :NERDTreeToggle
nmap  ut :UndotreeToggle
nmap  ll %s@^\%(ht|f\)tps\?://\(\S\+\)@<a href="&">\1</a>@g
nmap  b :ls:b 
nnoremap <silent>  a :ArgWrap
map  r :e %
map  s :spell!
nmap    :w
nmap  p <Plug>fov_new
nmap   :nohlsearch
nmap  pr :set list! nonumber norelativenumber
nmap  n :call NumberToggle()
nmap  h :Hexmode
nmap  l <Plug>fov_list
noremap  m mmHmt:%s///ge'tzt'm
map  cd :cd %:p:h:pwd
nmap  q :wqall
nnoremap   <Nop>
xnoremap <silent> <nop> :call UltiSnips#SaveLastVisualSelection()gvs
snoremap <silent> <nop> :call UltiSnips#ExpandSnippet()
nnoremap K :Man =expand("<cword>")
xmap S <Plug>VSurround
vmap <silent> T~ :call AlignMaps#Vis("T~")
nmap T~ <Plug>AM_T~
vmap <silent> Tsp :call AlignMaps#Vis("Tsp")
nmap Tsp <Plug>AM_Tsp
vmap <silent> Tab :call AlignMaps#Vis("Tab")
nmap Tab <Plug>AM_Tab
vmap <silent> TW@ :call AlignMaps#Vis("TW@")
nmap TW@ <Plug>AM_TW@
vmap <silent> T@ :call AlignMaps#Vis("T@")
nmap T@ <Plug>AM_T@
vmap <silent> T? :call AlignMaps#Vis("T?")
nmap T? <Plug>AM_T?
vmap <silent> T= :call AlignMaps#Vis("T=")
nmap T= <Plug>AM_T=
vmap <silent> T< :call AlignMaps#Vis("T<")
nmap T< <Plug>AM_T<
vmap <silent> T; :call AlignMaps#Vis("T;")
nmap T; <Plug>AM_T;
vmap <silent> T: :call AlignMaps#Vis("T:")
nmap T: <Plug>AM_T:
vmap <silent> Ts, :call AlignMaps#Vis("Ts,")
nmap Ts, <Plug>AM_Ts,
vmap <silent> T, :call AlignMaps#Vis("T,")
nmap T, <Plug>AM_T,
vmap <silent> T# :call AlignMaps#Vis("T#")
nmap T# <Plug>AM_T#
vmap <silent> T| :call AlignMaps#Vis("T|")
nmap T| <Plug>AM_T|
nmap [xx <Plug>unimpaired_line_xml_encode
xmap [x <Plug>unimpaired_xml_encode
nmap [x <Plug>unimpaired_xml_encode
nmap [uu <Plug>unimpaired_line_url_encode
xmap [u <Plug>unimpaired_url_encode
nmap [u <Plug>unimpaired_url_encode
nmap [yy <Plug>unimpaired_line_string_encode
xmap [y <Plug>unimpaired_string_encode
nmap [y <Plug>unimpaired_string_encode
nmap [p <Plug>unimpairedPutAbove
nnoremap [ov :set virtualedit+=all
nnoremap [ox :set cursorline cursorcolumn
nnoremap [od :diffthis
nnoremap [ob :set background=light
xmap [e <Plug>unimpairedMoveSelectionUp
nmap [e <Plug>unimpairedMoveUp
nmap [  <Plug>unimpairedBlankUp
omap [n <Plug>unimpairedContextPrevious
nmap [n <Plug>unimpairedContextPrevious
nmap [o <Plug>unimpairedOPrevious
nmap [f <Plug>unimpairedDirectoryPrevious
nmap <silent> [T <Plug>unimpairedTFirst
nmap <silent> [t <Plug>unimpairedTPrevious
nmap <silent> [ <Plug>unimpairedQPFile
nmap <silent> [Q <Plug>unimpairedQFirst
nmap <silent> [q <Plug>unimpairedQPrevious
nmap <silent> [ <Plug>unimpairedLPFile
nmap <silent> [L <Plug>unimpairedLFirst
nmap <silent> [l <Plug>unimpairedLPrevious
nmap <silent> [B <Plug>unimpairedBFirst
nmap <silent> [b <Plug>unimpairedBPrevious
nmap <silent> [A <Plug>unimpairedAFirst
nmap <silent> [a <Plug>unimpairedAPrevious
vmap [% [%m'gv``
nmap ]xx <Plug>unimpaired_line_xml_decode
xmap ]x <Plug>unimpaired_xml_decode
nmap ]x <Plug>unimpaired_xml_decode
nmap ]uu <Plug>unimpaired_line_url_decode
xmap ]u <Plug>unimpaired_url_decode
nmap ]u <Plug>unimpaired_url_decode
nmap ]yy <Plug>unimpaired_line_string_decode
xmap ]y <Plug>unimpaired_string_decode
nmap ]y <Plug>unimpaired_string_decode
nmap ]p <Plug>unimpairedPutBelow
nnoremap ]ov :set virtualedit-=all
nnoremap ]ox :set nocursorline nocursorcolumn
nnoremap ]od :diffoff
nnoremap ]ob :set background=dark
xmap ]e <Plug>unimpairedMoveSelectionDown
nmap ]e <Plug>unimpairedMoveDown
nmap ]  <Plug>unimpairedBlankDown
omap ]n <Plug>unimpairedContextNext
nmap ]n <Plug>unimpairedContextNext
nmap ]o <Plug>unimpairedONext
nmap ]f <Plug>unimpairedDirectoryNext
nmap <silent> ]T <Plug>unimpairedTLast
nmap <silent> ]t <Plug>unimpairedTNext
nmap <silent> ] <Plug>unimpairedQNFile
nmap <silent> ]Q <Plug>unimpairedQLast
nmap <silent> ]q <Plug>unimpairedQNext
nmap <silent> ] <Plug>unimpairedLNFile
nmap <silent> ]L <Plug>unimpairedLLast
nmap <silent> ]l <Plug>unimpairedLNext
nmap <silent> ]B <Plug>unimpairedBLast
nmap <silent> ]b <Plug>unimpairedBNext
nmap <silent> ]A <Plug>unimpairedALast
nmap <silent> ]a <Plug>unimpairedANext
vmap ]% ]%m'gv``
vmap <silent> anum :call AlignMaps#Vis("anum")
nmap anum <Plug>AM_anum
vmap <silent> aenum :call AlignMaps#Vis("aenum")
nmap aenum <Plug>AM_aenum
vmap <silent> aunum :call AlignMaps#Vis("aunum")
nmap aunum <Plug>AM_aunum
vmap <silent> afnc :call AlignMaps#Vis("afnc")
nmap afnc <Plug>AM_afnc
vmap <silent> adef :call AlignMaps#Vis("adef")
nmap adef <Plug>AM_adef
vmap <silent> adec :call AlignMaps#Vis("adec")
nmap adec <Plug>AM_adec
vmap <silent> ascom :call AlignMaps#Vis("ascom")
nmap ascom <Plug>AM_ascom
vmap <silent> aocom :call AlignMaps#Vis("aocom")
nmap aocom <Plug>AM_aocom
vmap <silent> adcom :call AlignMaps#Vis("adcom")
nmap adcom <Plug>AM_adcom
vmap <silent> acom :call AlignMaps#Vis("acom")
nmap acom <Plug>AM_acom
vmap <silent> abox :call AlignMaps#Vis("abox")
nmap abox <Plug>AM_abox
vmap <silent> a( :call AlignMaps#Vis("a(")
nmap a( <Plug>AM_a(
vmap <silent> a= :call AlignMaps#Vis("a=")
nmap a= <Plug>AM_a=
vmap <silent> a< :call AlignMaps#Vis("a<")
nmap a< <Plug>AM_a<
vmap <silent> a, :call AlignMaps#Vis("a,")
nmap a, <Plug>AM_a,
vmap <silent> a? :call AlignMaps#Vis("a?")
nmap a? <Plug>AM_a?
vmap a% [%v]%
nnoremap cov :set =(&virtualedit =~# "all") ? 'virtualedit-=all' : 'virtualedit+=all'
nnoremap cox :set =&cursorline && &cursorcolumn ? 'nocursorline nocursorcolumn' : 'cursorline cursorcolumn'
nnoremap cod :=&diff ? 'diffoff' : 'diffthis'
nnoremap cob :set background==&background == 'dark' ? 'light' : 'dark'
nmap cS <Plug>CSurround
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
vmap <silent> m= :call AlignMaps#Vis("m=")
nmap m= <Plug>AM_m=
vmap <silent> tt :call AlignMaps#Vis("tt")
nmap tt <Plug>AM_tt
vmap <silent> tsq :call AlignMaps#Vis("tsq")
nmap tsq <Plug>AM_tsq
vmap <silent> tsp :call AlignMaps#Vis("tsp")
nmap tsp <Plug>AM_tsp
vmap <silent> tml :call AlignMaps#Vis("tml")
nmap tml <Plug>AM_tml
vmap <silent> tab :call AlignMaps#Vis("tab")
nmap tab <Plug>AM_tab
vmap <silent> tW@ :call AlignMaps#Vis("tW@")
nmap tW@ <Plug>AM_tW@
vmap <silent> t@ :call AlignMaps#Vis("t@")
nmap t@ <Plug>AM_t@
vmap <silent> t~ :call AlignMaps#Vis("t~")
nmap t~ <Plug>AM_t~
vmap <silent> t? :call AlignMaps#Vis("t?")
nmap t? <Plug>AM_t?
vmap <silent> ts= :call AlignMaps#Vis("ts=")
nmap ts= <Plug>AM_ts=
vmap <silent> ts< :call AlignMaps#Vis("ts<")
nmap ts< <Plug>AM_ts<
vmap <silent> ts; :call AlignMaps#Vis("ts;")
nmap ts; <Plug>AM_ts;
vmap <silent> ts: :call AlignMaps#Vis("ts:")
nmap ts: <Plug>AM_ts:
vmap <silent> ts, :call AlignMaps#Vis("ts,")
nmap ts, <Plug>AM_ts,
vmap <silent> t= :call AlignMaps#Vis("t=")
nmap t= <Plug>AM_t=
vmap <silent> t< :call AlignMaps#Vis("t<")
nmap t< <Plug>AM_t<
vmap <silent> t; :call AlignMaps#Vis("t;")
nmap t; <Plug>AM_t;
vmap <silent> t: :call AlignMaps#Vis("t:")
nmap t: <Plug>AM_t:
vmap <silent> t, :call AlignMaps#Vis("t,")
nmap t, <Plug>AM_t,
vmap <silent> t# :call AlignMaps#Vis("t#")
nmap t# <Plug>AM_t#
vmap <silent> t| :call AlignMaps#Vis("t|")
nmap t| <Plug>AM_t|
vmap <silent> w= :call AlignMaps#Vis("w=")
nmap w= <Plug>AM_w=
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
nnoremap <silent> <Plug>(ctrlp) :CtrlPMixed
snoremap <silent> <Del> c
snoremap <silent> <BS> c
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
xnoremap <silent> <Plug>(openbrowser-smart-search) :call openbrowser#_keymapping_smart_search('v')
nnoremap <silent> <Plug>(openbrowser-smart-search) :call openbrowser#_keymapping_smart_search('n')
xnoremap <silent> <Plug>(openbrowser-search) :call openbrowser#_keymapping_search('v')
nnoremap <silent> <Plug>(openbrowser-search) :call openbrowser#_keymapping_search('n')
xnoremap <silent> <Plug>(openbrowser-open) :call openbrowser#_keymapping_open('v')
nnoremap <silent> <Plug>(openbrowser-open) :call openbrowser#_keymapping_open('n')
nnoremap <SNR>34_: :=v:count ? v:count : ''
nmap <silent> <Plug>unimpairedOPrevious <Plug>unimpairedDirectoryPrevious:echohl WarningMSG|echo "[o is deprecated. Use [f"|echohl NONE
nmap <silent> <Plug>unimpairedONext <Plug>unimpairedDirectoryNext:echohl WarningMSG|echo "]o is deprecated. Use ]f"|echohl NONE
nnoremap <silent> <Plug>unimpairedTLast :exe "".(v:count ? v:count : "")."tlast"
nnoremap <silent> <Plug>unimpairedTFirst :exe "".(v:count ? v:count : "")."tfirst"
nnoremap <silent> <Plug>unimpairedTNext :exe "".(v:count ? v:count : "")."tnext"
nnoremap <silent> <Plug>unimpairedTPrevious :exe "".(v:count ? v:count : "")."tprevious"
nnoremap <silent> <Plug>unimpairedQNFile :exe "".(v:count ? v:count : "")."cnfile"zv
nnoremap <silent> <Plug>unimpairedQPFile :exe "".(v:count ? v:count : "")."cpfile"zv
nnoremap <silent> <Plug>unimpairedQLast :exe "".(v:count ? v:count : "")."clast"zv
nnoremap <silent> <Plug>unimpairedQFirst :exe "".(v:count ? v:count : "")."cfirst"zv
nnoremap <silent> <Plug>unimpairedQNext :exe "".(v:count ? v:count : "")."cnext"zv
nnoremap <silent> <Plug>unimpairedQPrevious :exe "".(v:count ? v:count : "")."cprevious"zv
nnoremap <silent> <Plug>unimpairedLNFile :exe "".(v:count ? v:count : "")."lnfile"zv
nnoremap <silent> <Plug>unimpairedLPFile :exe "".(v:count ? v:count : "")."lpfile"zv
nnoremap <silent> <Plug>unimpairedLLast :exe "".(v:count ? v:count : "")."llast"zv
nnoremap <silent> <Plug>unimpairedLFirst :exe "".(v:count ? v:count : "")."lfirst"zv
nnoremap <silent> <Plug>unimpairedLNext :exe "".(v:count ? v:count : "")."lnext"zv
nnoremap <silent> <Plug>unimpairedLPrevious :exe "".(v:count ? v:count : "")."lprevious"zv
nnoremap <silent> <Plug>unimpairedBLast :exe "".(v:count ? v:count : "")."blast"
nnoremap <silent> <Plug>unimpairedBFirst :exe "".(v:count ? v:count : "")."bfirst"
nnoremap <silent> <Plug>unimpairedBNext :exe "".(v:count ? v:count : "")."bnext"
nnoremap <silent> <Plug>unimpairedBPrevious :exe "".(v:count ? v:count : "")."bprevious"
nnoremap <silent> <Plug>unimpairedALast :exe "".(v:count ? v:count : "")."last"
nnoremap <silent> <Plug>unimpairedAFirst :exe "".(v:count ? v:count : "")."first"
nnoremap <silent> <Plug>unimpairedANext :exe "".(v:count ? v:count : "")."next"
nnoremap <silent> <Plug>unimpairedAPrevious :exe "".(v:count ? v:count : "")."previous"
nnoremap <silent> <Plug>SurroundRepeat .
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <SNR>23_WE <Plug>AlignMapsWrapperEnd
map <SNR>23_WS <Plug>AlignMapsWrapperStart
nmap <silent> <F7> :set spell!
nmap <F1> 
xmap <BS> "-d
imap S <Plug>ISurround
imap s <Plug>Isurround
imap 	 <Plug>SuperTabForward
inoremap <expr>  pumvisible() ? "\=ExpandSnippetOrCarriageReturn()\" : "\"
imap  <Plug>Isurround
imap    :w
inoremap <silent> <nop> =UltiSnips#ExpandSnippet()
cnoremap \ 
imap hj 
imap jh 
cmap w!! %!sudo tee > /dev/null %
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,dos,mac
set formatoptions=cqtw
set helplang=en
set hlsearch
set ignorecase
set incsearch
set langmenu=none
set laststatus=2
set linespace=2
set listchars=tab:‚ñ∂-,nbsp:‹Å,trail:‚Ä¢,extends:¬ª,precedes:¬´,eol:¬¨
set mouse=a
set pastetoggle=<F2>
set runtimepath=~/.vim,~/.vim/plugged/vim-colorschemes/,~/.vim/plugged/writegooder.vim/,~/.vim/plugged/editorconfig-vim/,~/.vim/plugged/nerdcommenter/,~/.vim/plugged/supertab/,~/.vim/plugged/MatchTagAlways/,~/.vim/plugged/vim-surround/,~/.vim/plugged/vim-unimpaired/,~/.vim/plugged/vim-fugitive/,~/.vim/plugged/vim-fist/,~/.vim/plugged/yajs.vim/,~/.vim/plugged/jedi/,~/.vim/plugged/vim-python-combined/,~/.vim/plugged/vim-markdown/,~/.vim/plugged/open-browser.vim/,~/.vim/plugged/vim-web-indent/,~/.vim/plugged/vim-jsdoc/,~/.vim/plugged/vim-argwrap/,~/.vim/plugged/ultisnips/,~/.vim/plugged/vim-snippets/,~/.vim/plugged/vim-bootstrap3-snippets/,~/.vim/plugged/vim-template/,~/.vim/plugged/ctrlp.vim/,~/.vim/plugged/neocomplete.vim/,~/.vim/plugged/syntastic/,/usr/local/Cellar/macvim/7.4-104_1/MacVim.app/Contents/Resources/vim/vimfiles,/usr/local/Cellar/macvim/7.4-104_1/MacVim.app/Contents/Resources/vim/runtime,/usr/local/Cellar/macvim/7.4-104_1/MacVim.app/Contents/Resources/vim/runtime/pack/dist/opt/matchit,/usr/local/Cellar/macvim/7.
set shiftround
set shiftwidth=2
set shortmess=atI
set showcmd
set smartcase
set softtabstop=2
set statusline=\ b%n\ %<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set noswapfile
set textwidth=80
set title
set undodir=/tmp/vim_undo
set undofile
set wildmenu
set wrapmargin=4
" vim: set ft=vim :
