
s:bigrams=""

" add corpus to bigram list:
function! bigramcomplete#AddCorpus(filename)
    for m in split(readfile(s:bigrams))
      " do stuff to strip metadata from bigram store
      echomsg m
    endfor
    if writefile(data, s:bigrams)
      echomsg 'write error'
    endif
endfun

" completion engine:
function! bigramcomplete#Completer(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '.' || line[start - 1] =~ '-')
      let start -= 1
    endwhile
    return start
  else
    " find bigrams matching "a:base"
    let res = []
    for m in split(readfile(s:bigrams), '\n')
      if m =~ '^' . a:base
	call add(res, m)
      endif
    endfor
    return res
  endif
endfun
