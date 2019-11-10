" True Color options

set termguicolors

" Colorscheme

set background=dark			" Options: [light/dark]
"set background=light			" Options: [light/dark]

colorscheme gruvbox
let g:gruvbox_italic=1

" Rainbow parens options for all parentheses => defaults to `ON`
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

" Highlight keywords
" 	https://stackoverflow.com/questions/6577579/task-tags-in-vim

if has("nvim")
	" Highlight TODO, FIXME, NOTE, BUG, etc.
	autocmd Syntax * call matchadd('Todo',
				\ '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
	autocmd Syntax * call matchadd('Debug',
				\ '\W\zs\(NOTE\|INFO\|IDEA\)')
	autocmd FileType json syntax match Comment +\/\/.\+$+
endif
