" Some info for multiple vimwikis:
"	https://vi.stackexchange.com/a/7911/15268

let g:vimwiki_list = [{
			\ 'path': '~/vimwiki',
			\ 'template_path': '~/vimwiki/templates/',
			\ 'template_default': 'default',
			\ 'template_ext': '.html',
			\ 'nested_syntaxes': {'xml': 'xml', 'sh': 'sh', 'python': 'python', 'systemd': 'systemd'},
			\ 'path_html': '~/vimwiki/site_html'
			\ }]

function! ToggleCalendar()
	execute ":CalendarH"
	if exists("g:calendar_open")
		if g:calendar_open == 1
			execute "q"
			unlet g:calendar_open
		else
			g:calendar_open = 1
		end
	else
		let g:calendar_open = 1
	end
endfunction

autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>
