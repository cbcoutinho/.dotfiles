" vim:foldmethod=marker:foldlevel=0

" Interleave similar sized blocks {{{
"	https://vi.stackexchange.com/questions/4575
"
"	a1
"	a2
"	a3
"	a4
"	  b1
"	  b2
"	  b3
"	  b4
"
" becomes:
"
"	a1
"	  b1
"	a2
"	  b2
"	a3
"	  b3
"	a4
"	  b4

function! Interleave()
	" retrieve last selected area position and size
	let start = line(".")
	execute "normal! gvo\<esc>"
	let end = line(".")
	let [start, end] = sort([start, end], "n")
	let size = (end - start + 1) / 2
	" and interleave!
	for i in range(size - 1)
		execute (start + size + i). 'm' .(start + 2 * i)
	endfor
endfunction

" Select your two contiguous, same-sized blocks, and use it to
" Interleave ;)
"	NOTE: <leader> is backslash '\' by default
vnoremap <leader>it <esc>:call Interleave()<CR>

" }}}

" Add Fireplace (nREPL) connection status to statusline {{{
function! IsFireplaceConnected()
  try
    return has_key(fireplace#platform(), 'connection')
  catch /Fireplace: :Connect to a REPL or install classpath.vim/
    return 0 " false
  endtry
endfunction

function! NreplStatusLine()
  if IsFireplaceConnected()
    return 'nREPL Connected'
  else
    return 'No nREPL Connection'
  endif
endfunction

function! SetBasicStatusLine()
  set statusline=%f   " path to file
  set statusline+=\   " separator
  set statusline+=%m  " modified flag
  set statusline+=%=  " switch to right side
  set statusline+=%y  " filetype of file
endfunction

autocmd Filetype clojure call SetBasicStatusLine()
autocmd Filetype clojure set statusline+=\ [%{NreplStatusLine()}]  " REPL connection status
autocmd BufLeave *.cljs,*.clj,*.cljs.hl  call SetBasicStatusLine()

" }}}

" Highlights the current word under the cursor {{{

let g:highlight_current_keyword = 0
function! ToggleKeywordHighlight()
  if g:highlight_current_keyword == 0
    augroup highlight_keyword
      au!
      autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    augroup END
    let g:highlight_current_keyword = 1
  else
    augroup highlight_keyword
      au!
    augroup END
    match none
    let g:highlight_current_keyword = 0
  endif
endfunction
call ToggleKeywordHighlight()

" }}}
