" ftplugin/mail.vim
"
" Originally from:
"	http://www.mdlerch.com/2014/14-12-emailing-mutt-and-vim-advanced-config.html
function IsReply()
	if line('$') > 1
		:%!par w72q
		:%s/^.\+\ze\n\(>*$\)\@!/\0 /e
		:%s/^>*\zs\s\+$//e
		:1
		:put! =\"\n\n\"
		:1
	endif
endfunction

augroup mail_filetype
	autocmd!
	autocmd! VimEnter /tmp/mutt* :call IsReply()
augroup END

setl tw=72
setl fo=aw
