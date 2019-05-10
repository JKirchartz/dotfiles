"-----------------------------------------------------
" Various helper functions formerly in my vimrc, firstly:
"
" Toggle between number settings
"-------------------------------------------------------{{{
function! fun#NumberToggle()
	if &relativenumber == 1 && &number == 1
		set norelativenumber
		set nonumber
	elseif &relativenumber == 0 && &number == 1
		set relativenumber
	else
		set number
	endif
endfunc

"}}}-----------------------------------------------------
" Step through a list of colorschemes
"-------------------------------------------------------{{{

let g:colorNumber = 0
function! fun#ColorSchemeToggle()
	if exists("g:colorNumber")
		if !exists("g:colorSchemes")
			" default to schemes that ship with vim
			let g:colorSchemes = ["darkblue", "delek", "elflord", "industry", "morning", "pablo", "ron", "slate", "zellner", "blue", "default", "desert", "evening", "koehler", "murphy", "peachpuff", "shine", "torte"]
		endif
		execute 'colorscheme ' . g:colorSchemes[g:colorNumber]
		let g:colorNumber = (g:colorNumber + 1) % len(g:colorSchemes)
	endif
endfunction


"}}}-----------------------------------------------------
" Create an empty buffer for temporary data, etc
"-------------------------------------------------------{{{
function! fun#ScratchBuffer()
	exe ':new'
	exe ':setlocal buftype=nofile'
	exe ':setlocal bufhidden=hide'
	exe ':setlocal noswapfile'
endfunc

"}}}-----------------------------------------------------
" Toggle NetRW window
"-------------------------------------------------------{{{
function! fun#ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      if exists(':Lexplore')
        Lexplore
      else
        Vexplore
      endif
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

"}}}-----------------------------------------------------
" Make UltiSnips & VimCompletesMe (or completor.vim) play nice
"-------------------------------------------------------{{{
"function! fun#UltiComplete() abort
"	" from here: https://github.com/SirVer/ultisnips/issues/886#issuecomment-326829323
"	if empty(UltiSnips#SnippetsInCurrentScope(1))
"		return ''
"	endif
"	let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
"	let contain_word = 'stridx(v:val, word_to_complete)>=0'
"	let candidates = map(filter(keys(g:current_ulti_dict_info), contain_word),
"				\  "{
"				\      'word': v:val,
"				\      'menu': '[snip]',
"				\      'info': g:current_ulti_dict_info[v:val]['description'],
"				\      'dup' : 1,
"				\   }")
"	let from_where = col('.') - len(word_to_complete)
"	if !empty(candidates)
"		call complete(from_where, candidates)
"	endif
"	return ''
"endfunction
"
"function! fun#ExpandSnippetOrCarriageReturn()
"	" this works, but doesn't look like expected, it doesn't denote
"	" the snippet but looks like a regular ins-complete (e.g. from
"	" another buffer)
"	let snippet = UltiSnips#ExpandSnippetOrJump()
"	if g:ulti_expand_or_jump_res > 0
"		return snippet
"	else
"		return pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"	endif
"endfunction
"}}}-----------------------------------------------------
" Delete Duplicate Lines
"-------------------------------------------------------{{{
function! fun#DeleteDuplicateLines()
        %!awk 'seen[$0]++ == 0'
endfunction

"}}}-----------------------------------------------------
" Delete HTML/XML tags
"-------------------------------------------------------{{{
function! fun#DeleteHTMLTags()
        :%s/<\_.\{-1,\}>//g
endfunction

"}}}-----------------------------------------------------
" Hexmode, via http://vim.wikia.com/wiki/Improved_Hex_editing
"-------------------------------------------------------{{{

function fun#ToggleHex()
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
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
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



"}}}--------------------------------------------------
" Cleanup output from 'Query Scraper' bookmarklet: jkirchartz.com/demos/bookmarklets.html
"-------------------------------------------------------{{{

function fun#CleanQueryScraper()
	let xtemp = @x
	let @x = 'ji  ~ j0d/%<CR>@x'
"O%qqji  ~~ j0d/%
" 100@qkdkdkukdkd:wqa
	:g/^$/d
	:1
	:normal O%^[
	:normal @x
	" let @x = xtemp
endfunction

"}}}--------------------------------------------------
" Append height/width of image in current line
"-------------------------------------------------------{{{
function! fun#ImageSize()
	let imgcmd = 'identify -format "width:%[w]px;\nheight:%[h]px;" '
	" let line = split(getline('.'), "'")
	" let filename = line[1]
	let filename = expand('<cfile>')
	" this may work better than split, with some jiggering: echo matchstr(getline('.'),"'\\zs\\f\\+\\ze'")
	let imgsize = system(imgcmd . filename)
	call append(line('.'), split(imgsize, '\v\n'))
	norm j2==
endfunction

"}}}--------------------------------------------------
" get most prominent color if image in current line
"-------------------------------------------------------{{{

" convert fed_8282_clover_160x600_frame2-overlay.png -format %c -depth 8 histogram:info: | sort -n | tail -1 | cut -d' ' -f10,11
function! fun#ImageColor()
	let imgcmd = 'convert'
	let imgcmd2 = '-format %c -depth 8 histogram:info: | sort -n | tail -1 | cut -d\' \' -f10,11'
	let line = split(getline('.'), "'")
	let filename = line[1]
	let imgsize = system(imgcmd . filename)
	call append(line('.'), split(imgsize, '\v\n'))
	norm j==
endfunction


"}}}--------------------------------------------------
" Check all buffers for errors (with ALE)
"-------------------------------------------------------{{{
function! fun#AllALEBuffers()
	" check for errors
	for bufnr in range(1, bufnr('$'))
		if ale#statusline#Count(bufnr).total > 0
			caddexpr printf('%s:%s:%s', expand('%'), line('.'), "entry")
		endif
	endfor
	if count(clist)
		copen
	else
		echo "no errors found in open buffers"
	endif
endfunction

" }}}---------------------------------------------------
" Reset Highlights (ala https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f )
" ----------------------------------------------------{{{

function! fun#FixHighlights() abort
  highlight Normal ctermbg=None
  highlight NonText ctermbg=None
endfunction

" }}} fold up this file
" vim:foldmethod=marker
