" This file is based on the following vimcast:
"	http://vimcasts.org/episodes/writing-a-custom-fold-expression/
"
" It sets the folding rules so that muttrc files can be slightly more
" organized

function! MuttrcFolds()
	let thisline = getline(v:lnum)
	if match(thisline, '^##-') >= 0
		return ">1"
	elseif match(thisline, '^#-') >= 0
		return ">2"
	else
		return "="
	endif
	return "1"
endfunction
setlocal foldmethod=expr
setlocal foldexpr=MuttrcFolds()
