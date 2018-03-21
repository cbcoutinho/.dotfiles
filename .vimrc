" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

" Shell settings {{{

if has('win32')
	set shell=powershell.exe
	let g:python_host_prog='C:/Development/anaconda3/envs/neovim/python.exe'
	let g:python3_host_prog='C:/Development/anaconda3/envs/neovim3/python.exe'
	let g:ruby_host_prog='C:/Users/ccoutinho/scoop/apps/ruby/current/gems/bin/neovim-ruby-host.bat'
else
	"set shell=/bin/bash			" Force shell to use bash
endif

" }}}
" Vim settings {{{

filetype plugin indent on
set nocompatible			" Be iMproved, required for (n)vim
set number					" Line numbers
set relativenumber			" Relative line numbers w.r.t the cursor
set cursorline				" Highlight current line
set wildmenu				" Visual autocomplete for command menu - shows options when :sp _, etc
set showcmd					" Show command being typed on bottom right - useful for keymaps

"set spell					" By default spelling is `OFF`
set spelllang=en_us,nl		" Spelling language [en|nl]

" Space/Tab options {{{
"set expandtab               " Uses spaces instead of tabs
set tabstop     =4          " show existing tab with 4 spaces width
set shiftwidth  =4          " when indenting with '>', use 4 spaces width
"set softtabstop =4          " Tab key indents by 4 spaces
" NOTE: Python overrides space/tabs settings in:
"	$VIMRUNTIME/ftplugin/python.vim
set list					" Replaces certain whitespace with characters
set listchars=tab:>-		" Replaces <TAB> with >---
set listchars+=trail:x		" Replaces trailing whitespace with 'x'
" }}}
" Folding options {{{
" Code folding options are:
"	[marker, manual, expr, syntax, diff, indent]
"set foldmethod=marker
"set foldlevel=0
set modelines=1				" This tells vim to look at the last line for the fold method
" }}}

set backspace   =indent,eol,start   " Make backspace work as expected (i.e. wraps around end of line)
set ignorecase              " Ignore case in search results, using \C overrides this
set smartcase               " Ignores 'set ignorecase' if search contains upper case letter

set splitbelow				" Split new buffer below instead of above
set splitright				" Split new buffer right instead of left

" True Color options {{{
if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
	set termguicolors
elseif has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLORS=1
endif
" }}}

set nowrap                  " Don't wrap long lines automatically
set textwidth       =70     " Set textwidth to <n> chars, wrap after that
set formatoptions   +=t     " Automatically wrap lines after <textwidth> chars
set formatoptions   -=l     " Already long lines will also be auto-wrapped if appended to

" Further, from the wiki:
" If you want to wrap lines in a specific area, move the cursor to
" the text you want to format and type gq followed by the range. For
" example, gqq wraps the current line and gqip wraps the current
" paragraph.

if executable('par')        " See 'par' vimcast for amazing text wrangler
	set formatprg=par
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
		autocmd VimEnter * PlugInstall
	endfunction
	call GetPlugVim(plugfile,plug_url)
endif
" }}}
call plug#begin(plugin_dir)
" Language-specfic plugins {{{
" Completions in neovim {{{

if has('nvim')
	Plug 'roxma/nvim-completion-manager'
endif

" }}}
" Rust {{{

Plug 'rust-lang/rust.vim',				" Rust stuff
Plug 'racer-rust/vim-racer',			" Racer in vim
Plug 'roxma/nvim-cm-racer', 			" Neovim/vim8 completion for Rust

" }}}
" Python {{{

if has('unix')
	Plug 'direnv/direnv.vim'
endif

" }}}
" Lisp-like (e.g. Clojure) {{{

Plug 'tpope/vim-fireplace'				" Connects to the nREPL for 'dynamic' clojure development
Plug 'kien/rainbow_parentheses.vim'     " Rainbow parens for Lisps - see options below
if has('nvim-0.2.1')
	Plug 'snoe/nvim-parinfer.js', {'do':
				\ 'lein npm install'}
else
	" Parinfer port to rust
	Plug 'eraserhd/parinfer-rust', {'do':
				\ 'cargo +stable build --release --manifest-path=cparinfer/Cargo.toml'}
	" Parinfer port to VimL
	"Plug 'bhurlow/vim-parinfer'
endif

" }}}
" Golang {{{

Plug 'fatih/vim-go'

" }}}
" Markdown {{{

" View rendered markdown in vim
Plug 'euclio/vim-markdown-composer', {'do':
			\ 'cargo +stable build --release'}
Plug 'nelstrom/vim-markdown-folding'	" Easily fold markdown files by section


" }}}
" }}}
" Color schemes {{{

Plug 'morhetz/gruvbox'                  " Gruvbox theme for vim
Plug 'altercation/vim-colors-solarized' " Solarized theme for vim
Plug 'joshdick/onedark.vim'             " Onedark theme from Atom ported to vim
Plug 'sheerun/vim-polyglot'             " Syntax highlighting for different languages
Plug 'tyrannicaltoucan/vim-deep-space'

" }}}
" Supercollider vim plugin {{{

Plug 'supercollider/scvim'

" }}}
" Vim-related plugins {{{

Plug 'scrooloose/nerdtree'              " Project tree directory
Plug 'scrooloose/nerdcommenter'         " Easily comment lines
Plug 'tpope/vim-surround'               " Easily surround text with parens, quotes, etc.
Plug 'itchyny/lightline.vim'            " Status line for vim
Plug 'godlygeek/tabular'                " Easily align text based on a characher - see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'sjl/gundo.vim'					" View vim 'undo' as a tree

" }}}
" Vim/git-related plugins {{{

Plug 'tpope/vim-fugitive'               " Git plugin for vim
Plug 'tpope/vim-rhubarb'                " Git plugin for vim - extension for Github
Plug 'shumphrey/fugitive-gitlab.vim'    " Git plugin for vim - extension for Gitlab
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git plugin for vim - extension for NERDTree
Plug 'octref/RootIgnore'                " Git Plugin for Vim - ignore files in .gitignore
if has('nvim-0.2.0')
	" On debian (nvim-0.1.7), there is an api bug
	Plug 'airblade/vim-gitgutter'		" Git status in gutter (next to line numbers)
endif

" }}}
" Fix `gx` bug {{{

" Normal `gx` doesn't work, so we remap it
"	https://github.com/neovim/neovim/issues/4612
Plug 'tyru/open-browser.vim' "{
" Disable netrw gx mapping.
let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)
"}

" }}}
call plug#end()
" }}}
" Colors {{{
" Colorscheme {{{

set background=dark			" Options: [light/dark]

colorscheme gruvbox
let g:gruvbox_italic=1

"colorscheme deep-space
"let g:deepspace_italics=1

" }}}
" Rainbow Parentheses {{{

" Rainbow parens options for Lisps => defaults to `ON`
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

" }}}
" Highlight keywords {{{
" From https://stackoverflow.com/questions/6577579/task-tags-in-vim
if has("autocmd")
	" Highlight TODO, FIXME, NOTE, BUG, etc.
	if v:version > 701
		autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
		autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
	endif
endif

" }}}
" }}}
" Lightline {{{

" Extra `lightline` options found here: http://newbilityvery.github.io/2017/08/04/switch-to-lightline/
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
" Toggle NERDTree
noremap <C-n> :NERDTreeToggle<CR>

" Close Vim if NERDTree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Git gutter update time (in ms)
set updatetime=1000

" }}}
" Language-specific options {{{
" Rust {{{

" Options for vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" For rusty-tags support in rust files using vim
" Requires the `universal-ctags` package to be installed
" NOTE: Format is set in ~/.rusty-tags/config.toml
autocmd BufRead *.rs :setlocal tags+=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Auto-rustfmt on save. Make sure to have rustfmt installed
"	rustup component add rustfmt-preview
let g:rustfmt_autosave = 1

" }}}
" Fortran {{{
" Fortran specific spacing:
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1
" }}}
" LaTeX {{{
" Turns off spell checking in TeX comments
let g:tex_comment_nospell=1
" }}}
" }}}
" Keymaps {{{

"let mapleader=","		" Sets <leader> to ','

" Move vertically by line, doesn't skip over wrapped lines
nnoremap j gj
nnoremap k gk

" Highlights last insert text
nnoremap gV `[v`]

" jk is escape
"inoremap jk <esc>

" Make opening and closing folds easier
nnoremap <Space> za

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Close a fold when arrow keys
"nnoremap <Left> zm

" Filetype associations
au BufNewFile,BufRead *.cson set filetype=coffee
au BufNewFile,BufRead .shrc set filetype=sh     " Sets .shrc files to use sh syntax
au BufNewFile,BufRead *.cls set filetype=tex    " Sets .cls files to use latex syntax

" Remove highlighted search text after search/sed/etc by hitting <esc>
nnoremap <esc> :noh<return><esc>

" Toggle gundo with a keymap
nnoremap <leader>u :GundoToggle<CR>

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
" }}}

" vim:foldmethod=marker:foldlevel=0
