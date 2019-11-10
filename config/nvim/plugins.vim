
" Plugins {{{

let plugin_dir = stdpath('data') . "/plugged"
if !isdirectory(plugin_dir)
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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

" Float completions
Plug 'ncm2/float-preview.nvim'

Plug 'dense-analysis/ale'					" Async linting/fixing using LSP

Plug 'zchee/deoplete-jedi' " Python
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
Plug 'l04m33/vlime', {
			\ 'rtp': 'vim' }			" Common lisp dev environment for (neo)vim

" Parinfer re-implementation in Rust
Plug 'eraserhd/parinfer-rust', {
			\ 'do': function('BuildParinferRust') }
"Plug 'file:///home/chris/Projects/parinfer-rust', {
			"\ 'do': function('BuildParinferRust') }

Plug 'Olical/conjure', { 'tag': '*', 'do': 'bin/compile' }

" }}}
" Scala {{{

Plug 'derekwyatt/vim-scala'
Plug 'ktvoelker/sbt-vim'

" }}}
" Golang {{{

if has('nvim-0.3.1')
	" Only use a tagged release of vim-go
	"Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries'}
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
" Apex/Salesforce {{{

"Plug 'neowit/vim-force.com'

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

" Snippets in neovim
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'neomake/neomake'

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
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview


let g:ale_linters = {
			\ 'python': ['flake8'],
			\ 'clojure': ['clj-kondo', 'joker'],
			\ 'rust': ['rls', 'cargo', 'rustc']
			\}
let g:ale_fixers = {
			\ 'rust': ['rustfmt'],
			\ 'python': ['black']
			\}
let g:ale_completion_enabled = 1

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

" }}}