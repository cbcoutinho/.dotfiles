" vim:foldmethod=marker

let plugin_dir = stdpath('data') . "/plugged"
if !isdirectory(plugin_dir)
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(plugin_dir)
" Build Function(s) {{{

" For vim/nvim compatibility, see 'euclio/vim-markdown-composer'
function! BuildRust(info)
	if a:info.status != 'unchanged' || a:info.force
		!cargo +stable build --release
	endif
endfunction

" }}}
" Language-specfic plugins {{{
" Completions in neovim {{{

"Plug 'dense-analysis/ale'					" Async linting/fixing using LSP
Plug 'neoclide/coc.nvim',
		\ {'branch': 'release'}

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

Plug 'clojure-vim/async-clj-omni'		" Completion engine for clojure
Plug 'tpope/vim-fireplace'				" Connects to the nREPL for 'dynamic' clojure development
Plug 'tpope/vim-classpath'				" Sets a classpath for lein commands in vim
Plug 'jpalardy/vim-slime'				" Send text to another pane (ie. with a REPL)
Plug 'venantius/vim-cljfmt'				" Format clojure files in vim - requires cljfmt
Plug 'guns/vim-slamhound'				" Reconstruct/simplify namespaces
Plug 'guns/vim-clojure-highlight'		" Better clojure syntax highlighting

" Parinfer re-implementation in Rust
Plug 'eraserhd/parinfer-rust', {
			\ 'do': function('BuildRust') }

"Plug 'Olical/conjure', { 'tag': '*', 'do': 'bin/compile' }

" }}}
" Scala {{{

Plug 'derekwyatt/vim-scala'
Plug 'ktvoelker/sbt-vim'

" }}}
" Markdown {{{

" View rendered markdown in vim
Plug 'euclio/vim-markdown-composer', {
			\ 'do': function('BuildRust') }
"Plug 'nelstrom/vim-markdown-folding'	" Easily fold markdown files by section
Plug 'plasticboy/vim-markdown'

" }}}
" Apex/Salesforce {{{

"Plug 'neowit/vim-force.com'

" }}}
" C# {{{

"Plug 'OrangeT/vim-csharp', {'for':['cs','csx','cshtml.html','csproj','solution']}
Plug 'OmniSharp/omnisharp-vim', {'for':['cs','csx','cshtml.html','csproj','solution'], 'on': ['OmniSharpInstall']}

" }}}
" }}}
" Color {{{

Plug 'morhetz/gruvbox'                  " Gruvbox theme for vim
Plug 'sheerun/vim-polyglot'             " Syntax highlighting for different languages
Plug 'kien/rainbow_parentheses.vim'     " Rainbow parens for Lisps - see options below

" }}}
" Vim-related plugins {{{

Plug 'preservim/nerdtree'				" Project tree directory
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
Plug 'vito-c/jq.vim' 					" Vim syntax for jq
Plug 'pearofducks/ansible-vim'			" Vim syntax for ansible playbooks
Plug 'gurpreetatwal/vim-avro'			" Vim syntax for avro

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
				"\ 'do': { -> fzf#install() }
				\ 'do': './install --all --no-update-rc' }
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

"let g:ale_linters = {
			"\ 'python': ['flake8', 'pylint'],
			"\ 'clojure': ['clj-kondo', 'joker'],
			"\ 'rust': ['rls', 'cargo', 'rustc'],
			"\ 'scala': ['metals'],
			"\ 'cs': ['OmniSharp']
			"\}
"let g:ale_fixers = {
			"\ 'rust': ['rustfmt'],
			"\ 'python': ['black'],
			"\ 'scala': ['scalafmt']
			"\}
"let g:ale_completion_enabled = 1

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

let g:apex_backup_folder = '/tmp/apex/backup'
let g:apex_temp_folder = '/tmp/apex/tmp'
"let g:apex_properties_folder =
"let g:apex_tooling_force_dot_com_path = expand('~/Downloads/tooling-force.com-0.4.4.0.jar')

let g:fugitive_gitlab_domains = ['https://gitlab.carnext.io']
