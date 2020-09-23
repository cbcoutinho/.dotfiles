"let mapleader=","		" Sets <leader> to ','

" Move vertically by line, doesn't skip over wrapped lines
nnoremap j gj
nnoremap k gk

" Highlights last insert text
nnoremap gV `[v`]

" Make opening and closing folds easier
nnoremap <Space> za

" Switch between fixing cursor with `scrolloff`:
"	http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Remove highlighted search text after search/sed/etc by hitting <esc>
nnoremap <esc> :noh<return><esc>

" Toggle gundo with a keymap
nnoremap <leader>u :GundoToggle<CR>

" Toggle NERDTree with a keymap
nnoremap <leader>nt :NERDTreeToggle<CR>

" Revert git hunks in visual mode
"	https://github.com/airblade/vim-gitgutter/issues/55#issuecomment-15113725
vmap <silent> u <esc>:Gdiff<cr>gv:diffget<cr><c-w><c-w>ZZ

" Easily navigate git hunks (requires GitGutter plugin)
"	https://kinbiko.com/vim/my-shiniest-vim-gems/
nnoremap <c-N> :GitGutterNextHunk<CR>
nnoremap <c-P> :GitGutterPrevHunk<CR>
nnoremap <c-U> :GitGutterUndoHunk<CR>

" Auto-selects the git diff when inspecting vim plugins via vim-plug
autocmd! FileType vim-plug nmap <buffer> o <plug>(plug-preview)<c-w>P

" fzf plugins
" 	https://statico.github.io/vim3.html
" 	http://seenaburns.com/vim-setup-for-scala/
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob="!.git" --no-messages "" .'
endif

" Use FZF for files and tags if available, otherwise fall back onto CtrlP
" <leader>j will search for tag using word under cursor
let g:fzf_command_prefix = 'Fzf'
nnoremap ; 			:FzfBuffers<CR>
nnoremap <leader>t 	:FzfFiles<cr>
nnoremap <leader>r 	:FzfTags<cr>
nnoremap <leader>j 	:call fzf#vim#tags("'".expand('<cword>'))<cr>


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Snippets {{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" }}}
