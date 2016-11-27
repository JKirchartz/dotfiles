"-----------------------------------------------------
" Various helper functions formerly in my vimrc, firstly:
"
" Toggle between number settings
"-------------------------------------------------------{{{
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

"}}}-----------------------------------------------------
" Create an empty buffer for temporary data, etc
"-------------------------------------------------------{{{
function! ScratchBuffer()
	exe ':new'
	exe ':setlocal buftype=nofile'
	exe ':setlocal bufhidden=hide'
	exe ':setlocal noswapfile'
endfunc

"}}}-----------------------------------------------------
" Toggle NetRW window
"-------------------------------------------------------{{{
function! ToggleVExplorer()
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
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif
endfunction

" fold up this file
" vim:foldmethod=marker
