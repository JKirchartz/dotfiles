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
" Make UltiSnips & VimCompletesMe play nice
"-------------------------------------------------------{{{
function! fun#ExpandSnippetOrCarriageReturn()
    " this works, but doesn't look like expected, it doesn't denote the
    " snippet but looks like a regular ins-complete (e.g. from another buffer)
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif
endfunction

"}}}-----------------------------------------------------
" Delete Duplicate Lines
"-------------------------------------------------------{{{
function! fun#DeleteDuplicateLines()
        %!awk 'seen[$0]++ == 0'
endfunction

" fold up this file
" vim:foldmethod=marker
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
"C
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
