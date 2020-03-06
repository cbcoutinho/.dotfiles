
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
set listchars+=extends:>	" Shows in last column when characters extend past pane to the right
set listchars+=precedes:<	" Shows in first column when characters extend past pane to the left
set listchars+=nbsp:.
set listchars+=eol:%

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

" Filetype associations
au BufNewFile,BufRead *.cson set filetype=coffee
au BufNewFile,BufRead .shrc set filetype=sh     " Sets .shrc files to use sh syntax
au BufNewFile,Bufread *.wiki set filetype=vimwiki
au BufNewFile,Bufread Pipfile.lock set filetype=json
au BufNewFile,BufRead *.sbt set filetype=scala
au BufNewFile,BufRead *.cls set filetype=java    " Sets .cls files to use java syntax (Salesforce)

" Usually for OpenFOAM/foam files
au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif

" }}}
" }}}
