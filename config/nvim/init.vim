" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

" Shell settings {{{

if has('win32')
	set shell=powershell.exe
	let g:python_host_prog='C:/Development/anaconda3/envs/neovim/python.exe'
	let g:python3_host_prog='C:/Development/anaconda3/envs/neovim3/python.exe'
	let g:ruby_host_prog='C:/Users/ccoutinho/scoop/apps/ruby/current/gems/bin/neovim-ruby-host.bat'
else
	set shell=sh			" Force shell to use bash
	let g:python_host_prog='/home/chris/.local/share/virtualenvs/neovim/bin/python'
	let g:python3_host_prog='/home/chris/.local/share/virtualenvs/neovim3/bin/python3'
	let g:ruby_host_prog=systemlist("which neovim-ruby-host")[0]
	let g:npm_host_prog=system("which npm | sed 's/npm/neovim-node-host/'")
endif

" }}}
" Plugins {{{
" Download and install `plug-vim` {{{
if has('win32')
	let plugfile = 'C:/Users/ccoutinho/AppData/Local/nvim/autoload/plug.vim'
	let plugin_dir = 'C:/Users/ccoutinho/AppData/Local/nvim/plugged'

	" https://github.com/equalsraf/neovim-qt/issues/327
	source $VIMRUNTIME/mswin.vim
else
	if has('nvim')
		let plugfile = '~/.local/share/nvim/site/autoload/plug.vim'
		let plugin_dir = '~/.local/share/nvim/plugged'
	else
		let plugfile = '~/.vim/autoload/plug.vim'
		let plugin_dir = '~/.vim/plugged'
	endif
endif

if empty(glob(plugfile))
	let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	function GetPlugVim(plugfile, plug_url)
		if has('win32')
			"execute "!echo `plug.vim` not found, first download it manually."
			execute "!md -Force ~/AppData/Local/nvim/autoload;"
						\ "$url = '" a:plug_url "'; $url = $url.replace(' ','');"
						\ "$file = '" a:plugfile "'; $file = $file.replace(' ','');"
						\ "(New-Object Net.WebClient).DownloadFile( $url, "
						\ " $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath( $file ))"
		else
			" Unix world
			execute '!curl -fLo'
						\ a:plugfile
						\ '--create-dirs'
						\ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		endif
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endfunction
	call GetPlugVim(plugfile,plug_url)
endif
" }}}
call plug#begin(plugin_dir)
" Build Function(s) {{{

" For vim/nvim compatibility, see 'euclio/vim-markdown-composer'
function! BuildComposer(info)
	if a:info.status != 'unchanged' || a:info.force
		if has('nvim')
			!cargo +stable build --release
		else
			!cargo +stable build --release --no-default-features --features json-rpc
		endif
	endif
endfunction

function! BuildParinferRust(info)
	if a:info.status != 'unchanged' || a:info.force
		!cargo +stable build --release
	endif
endfunction

function! BuildParinferClojure(info)
	if a:info.status != 'unchanged' || a:info.force
		!lein npm install
	endif
endfunction

" }}}
" Language-specfic plugins {{{
" Completions in neovim {{{

"Plug 'roxma/nvim-yarp'	" Requirement of ncm2
"Plug 'ncm2/ncm2'

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
"Plug 'ncm2/ncm2-path'

" Language specific completions
"Plug 'ncm2/ncm2-jedi'  " Python
"Plug 'ncm2/ncm2-racer' " Rust

Plug 'w0rp/ale'					" Async linting/fixing using LSP

if has('nvim-0.3')
	Plug 'zchee/deoplete-jedi' " Python
	Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" }}}
" Rust {{{

Plug 'rust-lang/rust.vim',		" Rust stuff
Plug 'racer-rust/vim-racer',	" Racer in vim
Plug 'roxma/nvim-cm-racer', 	" Neovim/vim8 completion for Rust

" }}}
" Python {{{

if has('unix')
	Plug 'direnv/direnv.vim'
endif

"Plug 'davidhalter/jedi-vim'

" }}}
" Lisp-like (e.g. Clojure) {{{

Plug 'tpope/vim-fireplace'				" Connects to the nREPL for 'dynamic' clojure development
Plug 'tpope/vim-classpath'				" Sets a classpath for lein commands in vim
Plug 'jpalardy/vim-slime'				" Send text to another pane (ie. with a REPL)
Plug 'venantius/vim-cljfmt'				" Format clojure files in vim - requires cljfmt
Plug 'guns/vim-slamhound'				" Reconstruct/simplify namespaces
Plug 'guns/vim-clojure-highlight'		" Better clojure syntax highlighting
Plug 'l04m33/vlime', {
			\ 'rtp': 'vim' }			" Common lisp dev environment for (neo)vim

" Parinfer re-implementation in Rust
Plug 'eraserhd/parinfer-rust', {
			\ 'do': function('BuildParinferRust') }
"Plug 'file:///home/chris/Projects/parinfer-rust', {
			"\ 'do': function('BuildParinferRust') }

" }}}
" Golang {{{

if has('nvim-0.3.1')
	" Only use a tagged release of vim-go
	Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries'}
endif

" }}}
" Markdown {{{

" View rendered markdown in vim
Plug 'euclio/vim-markdown-composer', {
			\ 'do': function('BuildComposer') }
Plug 'nelstrom/vim-markdown-folding'	" Easily fold markdown files by section

" }}}
" MOOSE{{{

Plug 'elementx54/moosefw_vim'

" }}}
" }}}
" Color {{{

Plug 'morhetz/gruvbox'                  " Gruvbox theme for vim
Plug 'sheerun/vim-polyglot'             " Syntax highlighting for different languages
Plug 'kien/rainbow_parentheses.vim'     " Rainbow parens for Lisps - see options below

" }}}
" Supercollider vim plugin {{{

Plug 'supercollider/scvim'

" }}}
" Vim-related plugins {{{

Plug 'scrooloose/nerdtree'				" Project tree directory
Plug 'scrooloose/nerdcommenter'			" Easily comment lines
Plug 'tpope/vim-surround'				" Easily surround text with parens, quotes, etc.
Plug 'itchyny/lightline.vim'			" Status line for vim
Plug 'godlygeek/tabular'				" Easily align text based on a characher - see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'sjl/gundo.vim'					" View vim 'undo' as a tree
Plug 'vimwiki/vimwiki', {
			\ 'branch': 'dev' }			" Personal diary/wiki
Plug 'mattn/calendar-vim'				" Places calendar into a pane
Plug 'junegunn/goyo.vim'				" Distraction-free writing in vim
Plug 'junegunn/limelight.vim'			" Highlight current paragraph in Goyo-mode

Plug 'Konfekt/FastFold'					" Recommended by SimpylFold
Plug 'tmhedberg/SimpylFold'				" Fold python source files

Plug 'neomutt/neomutt.vim'				" Vim syntax for neomutt


" }}}
" Vim/git-related plugins {{{

Plug 'tpope/vim-fugitive'               " Git plugin for vim
Plug 'tpope/vim-rhubarb'                " Git plugin for vim - extension for Github
Plug 'shumphrey/fugitive-gitlab.vim'    " Git plugin for vim - extension for Gitlab
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git plugin for vim - extension for NERDTree
Plug 'octref/RootIgnore'                " Git Plugin for Vim - ignore files in .gitignore
Plug 'airblade/vim-gitgutter'			" Git status in gutter (next to line numbers)

" }}}
" Fuzzy search {{{

if has('unix')
	" Fuzzy search for vim - doesn't work on windows
	Plug 'junegunn/fzf', {
				\ 'dir': '~/.fzf',
				\ 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
endif

" }}}
" Fix `gx` bug {{{

" Normal `gx` doesn't work, so we remap it
"	https://github.com/neovim/neovim/issues/4612
Plug 'tyru/open-browser.vim'

let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

" }}}
call plug#end()

" Activate deoplete after vim-plug is done
" NOTE: Deoplete is not installed for nvim<0.3
let g:deoplete#enable_at_startup = 1

" }}}
" Vim settings {{{
" Basics {{{

filetype plugin indent on
set nocompatible			" Be iMproved, required for (n)vim
set number					" Line numbers
set relativenumber			" Relative line numbers w.r.t the cursor
set cursorline				" Highlight current line
set wildmenu				" Visual autocomplete for command menu - shows options when :sp _, etc
set showcmd					" Show command being typed on bottom right - useful for keymaps
set autoread				" Automatically reloads files that were edited externally

"set spell					" By default spelling is `OFF`
set spelllang=en_us,nl		" Spelling language [en|nl]

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" }}}
" Space/Tab options {{{

"set expandtab               " Uses spaces instead of tabs
set tabstop     =4          " show existing tab with 4 spaces width
set shiftwidth  =4          " when indenting with '>', use 4 spaces width
"set softtabstop =4          " Tab key indents by 4 spaces
" NOTE: Python overrides space/tabs settings in:
"	$VIMRUNTIME/ftplugin/python.vim
set list					" Replaces certain whitespace with characters
"set listchars=tab:>-		" Replace <TAB> with >---
set listchars+=trail:·		" Replace trailing whitespace with '·'
set listchars+=extends:#	" Shows in last column when characters extend past pane
set listchars+=nbsp:.

set listchars+=tab:▸\ 		" Replace <TAB> with ▸
set listchars+=eol:¬		" Replace EOL with ¬

" }}}
" Formatting {{{

set backspace   =indent,eol,start   " Make backspace work as expected (i.e. wraps around end of line)
set ignorecase              " Ignore case in search results, using \C overrides this
set smartcase               " Ignores 'set ignorecase' if search contains upper case letter
set splitbelow				" Split new buffer below instead of above
set splitright				" Split new buffer right instead of left
set nowrap                  " Don't wrap long lines automatically
set textwidth       =70     " Set textwidth to <n> chars, wrap after that

" Default format options: tcqj (in vimrc: jcroql)
set formatoptions   +=t     " Automatically wrap lines after <textwidth> chars
set formatoptions   +=l     " Already long lines will not be auto-wrapped if appended to

" Further, from the wiki:
" If you want to wrap lines in a specific area, move the cursor to
" the text you want to format and type gq followed by the range. For
" example, gqq wraps the current line and gqip wraps the current
" paragraph.

if executable('par')        " See 'par' vimcast for amazing text wrangler
	set formatprg=par
endif

" }}}
" Folding options {{{

" Code folding options are:
"	[marker, manual, expr, syntax, diff, indent]
"set foldmethod=marker
"set foldlevel=0
set modelines=1				" This tells vim to look at the last line for the fold method

" Options for SimpyFold (python folding plugin)
let g:SimpylFold_docstring_preview = 1 " Preview docstring in fold text
let g:SimpylFold_fold_docstring = 0
let b:SimpylFold_fold_docstring = 0
"let g:SimpylFold_fold_import = 0
"let b:SimpylFold_fold_import = 0

" }}}
" }}}
" Colors {{{
" True Color options {{{

set termguicolors

" }}}
" Colorscheme {{{

set background=dark			" Options: [light/dark]
"set background=light			" Options: [light/dark]

colorscheme gruvbox
let g:gruvbox_italic=1

" }}}
" Rainbow Parentheses {{{

" Rainbow parens options for all parentheses => defaults to `ON`
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

" }}}
" Highlight keywords {{{
" 	https://stackoverflow.com/questions/6577579/task-tags-in-vim

if has("nvim")
	" Highlight TODO, FIXME, NOTE, BUG, etc.
	autocmd Syntax * call matchadd('Todo',
				\ '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
	autocmd Syntax * call matchadd('Debug',
				\ '\W\zs\(NOTE\|INFO\|IDEA\)')
endif

" }}}
" }}}
" Lightline {{{

" Extra `lightline` options found here:
" 	http://newbilityvery.github.io/2017/08/04/switch-to-lightline/
let g:lightline = {
			\	'colorscheme':'gruvbox',
			\	'active': {
			\		'left': [ ['mode', 'paste'],
			\			['gitbranch', 'readonly', 'filename', 'modified']
			\		],
			\	},
			\	'component': {
			\		'lineinfo': ' %3l:%-2v',
			\	},
			\	'component_function': {
			\		'gitbranch': 'fugitive#head',
			\	},
			\	}
let g:lightline.separator = {
			\	'left': '', 'right': '',
			\	}
let g:lightline.tabline = {
			\	'left': [ ['tabs'] ],
			\	'right': [ ['close'] ]
			\	}

" Status is already in lightline - no need for redundency
set noshowmode

" }}}
" NERDTree {{{

" Allows NERDTree to show .dot files
"let NERDTreeShowHidden=1
let NERDTreeRespectWildIgnore=1
let loaded_netrwPlugin=1

" Close Vim if NERDTree is last window open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Git gutter update time (in ms)
set updatetime=1000

" }}}
" REPL/SLIME {{{
" SLIME is a plugin that makes it possible to send data between
" multiplexer (e.g. TMUX) panes using vim. This is useful for any
" REPL-based workflow like Clojure (lein repl) and Python (IPython).

if exists('$TMUX')
	let g:slime_target = "tmux"
	let g:slime_paste_file = "$HOME/.slime_paste"
	let g:slime_python_ipython = 1
	let g:slime_default_config = {
				\ "socket_name": split($TMUX, ",")[0],
				\ "target_pane": ":.2",
				\ }

	" For vim-matlab plugin
	let g:matlab_server_launcher = 'tmux'
endif

" }}}
" Vlime {{{
"
" Originally from:
"	https://asciinema.org/a/129756

let g:vlime_leader = ','

let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

" }}}
" VimWiki {{{

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

" ToggleCalendar function {{{

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

:autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>

" }}}

" }}}
" Keymaps {{{

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

" Filetype associations
au BufNewFile,BufRead *.cson set filetype=coffee
au BufNewFile,BufRead .shrc set filetype=sh     " Sets .shrc files to use sh syntax
au BufNewFile,BufRead *.cls set filetype=tex    " Sets .cls files to use latex syntax
au BufNewFile,Bufread *.wiki set filetype=vimwiki
au BufNewFile,Bufread Pipfile.lock set filetype=json

" Usually for OpenFOAM/foam files
au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif

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
nnoremap ; :Buffers<CR>
nnoremap <Leader>t :Files<CR>
nnoremap <Leader>r :Tags<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" }}}
" Functions {{{

" Interleave Function {{{
" Interleave similar sized blocks, from:
"	https://vi.stackexchange.com/questions/4575

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
" Check Fireplace (clojure) connection {{{

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

" }}}

" vim:foldmethod=marker:foldlevel=0
