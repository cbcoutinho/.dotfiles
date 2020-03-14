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

Plug 'dense-analysis/ale'					" Async linting/fixing using LSP

Plug 'zchee/deoplete-jedi' " Python
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ncm2/float-preview.nvim'

" Language server in Rust
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }

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
Plug 'nelstrom/vim-markdown-folding'	" Easily fold markdown files by section

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
" Supercollider vim plugin {{{

Plug 'supercollider/scvim'

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

" Snippets in neovim
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

"Plug 'neomake/neomake'

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
call deoplete#custom#option('keyword_patterns', {
			\ 'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'}
			\)
set completeopt-=preview


let g:ale_linters = {
			\ 'python': ['flake8'],
			\ 'clojure': ['clj-kondo', 'joker'],
			\ 'rust': ['rls', 'cargo', 'rustc'],
			\ 'scala': ['metals' ],
			\ 'cs': ['OmniSharp']
			\}
let g:ale_fixers = {
			\ 'rust': ['rustfmt'],
			\ 'python': ['black'],
			\ 'scala': ['scalafmt']
			\}
let g:ale_completion_enabled = 1

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40



let g:apex_backup_folder = '/tmp/apex/backup'
let g:apex_temp_folder = '/tmp/apex/tmp'
"let g:apex_properties_folder =
"let g:apex_tooling_force_dot_com_path = expand('~/Downloads/tooling-force.com-0.4.4.0.jar')
