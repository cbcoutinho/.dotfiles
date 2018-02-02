" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

set shell=/bin/bash         " Force shell to use bash
set nocompatible            " Be iMproved, required for (n)vim
set number                  " Line numbers
set relativenumber          " Relative line numbers w.r.t the cursor

filetype plugin indent on
set expandtab               " Uses spaces instead of tabs
set tabstop     =4          " show existing tab with 4 spaces width
set shiftwidth  =4          " when indenting with '>', use 4 spaces width
set softtabstop =4          " Tab key indents by 4 spaces
set backspace   =indent,eol,start   " Make backspace work as expected
set ignorecase              " Ignore case in search results, using \C overrides this
set smartcase               " Ignores 'set ignorecase' if search contains upper case letter

if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
elseif has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLORS=1
endif

set nowrap                  " Don't wrap long lines automatically
set textwidth       =70     " Set textwidth to <n> chars, wrap after that
set formatoptions   +=t     " Automatically wrap lines after <textwidth> chars
set formatoptions   -=l     " Already long lines will also be auto-wrapped if appended to

" Fortran specific spacing:
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

" Further, from the wiki:
" If you want to wrap lines in a specific area, move the cursor to the
" text you want to format and type gq followed by the range.  For
" example, gqq wraps the current line and gqip wraps the current
" paragraph.

if executable('par')        " See 'par' vimcast for amazing text wrangler
    set formatprg=par
endif

" Spell checking
set spell spelllang=en_us
au BufNewFile,BufRead .shrc set filetype=sh     " Sets .shrc files to use sh syntax
au BufNewFile,BufRead *.cls set filetype=tex    " Sets .cls files to use latex syntax

if has('nvim')
	let plugfile = '~/.local/share/nvim/site/autoload/plug.vim'
	let plugin_dir = '~/.local/share/nvim/plugged'
else
	let plugfile = '~/.vim/autoload/plug.vim'
	let plugin_dir = '~/.vim/plugged'
endif

if empty(glob(plugfile))
    function GetPlugVim(plugfile)
        execute '!curl -fLo'
        \ a:plugfile
        \ '--create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall
    endfunction
    call GetPlugVim(plugfile)
endif

call plug#begin(plugin_dir)

" Language specific plugins
" Completions in neovim
if has('nvim')
    Plug 'roxma/nvim-completion-manager'
endif

" Fortran
"Plug 'vim-scripts/fortran.vim'      " Extra indentation rules for Fortran

" Rust
Plug 'rust-lang/rust.vim'           " Rust stuff
Plug 'racer-rust/vim-racer'         " Racer in vim
Plug 'roxma/nvim-cm-racer'          " Neovim/vim8 completion for Rust

" Lisp-like (e.g. Clojure)
if has('nvim-0.1.5')
    Plug 'snoe/nvim-parinfer.js'    " Lisp parens auto-adjust for nvim 0.1.5+
else
    Plug 'bhurlow/vim-parinfer'     " Vim port of nvim-parinfer.js
endif

" Color schemes
Plug 'morhetz/gruvbox'                  " Gruvbox theme for vim
Plug 'altercation/vim-colors-solarized' " Solarized theme for vim
Plug 'joshdick/onedark.vim'             " Onedark theme from Atom ported to vim
Plug 'sheerun/vim-polyglot'             " Syntax highlighting for different languages


" Vim-related plugins
Plug 'scrooloose/nerdtree'              " Project tree directory
Plug 'scrooloose/nerdcommenter'         " Easily comment lines
Plug 'tpope/vim-surround'               " Easily surround text with parens, quotes, etc.
Plug 'itchyny/lightline.vim'            " Status line for vim

" Vim/git-related plugins
Plug 'tpope/vim-fugitive'               " Git plugin for vim
Plug 'tpope/vim-rhubarb'                " Git plugin for vim - extension for Github
Plug 'shumphrey/fugitive-gitlab.vim'    " Git plugin for vim - extension for Gitlab
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git plugin for vim - extension for NERDTree
Plug 'airblade/vim-gitgutter'           " Git status in gutter (next to line numbers)

" All of your Plugins must be added before the following line
call plug#end()

colorscheme gruvbox
let g:gruvbox_italic=1 	" Allows italics for gruvbox
set background=dark 	" Options: [light/dark]
let g:lightline = {'colorscheme':'gruvbox'}

"colorscheme solarized
"set background=dark 	" Options: [light/dark]
"let g:lightline = {'colorscheme':'solarized'}

"let g:onedark_terminal_italics=1 	" Allows italics for onedark
"colorscheme onedark
"let g:lightline = {'colorscheme':'onedark'}

set noshowmode          " Status is already in lightline - no need for redundency

""" Rust Lang Options
" Options for vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" For rusty-tags support in rust files using vim
" Requires the `exuberant-ctags` package to be installed
autocmd BufRead *.rs :setlocal tags+=./.rusty-tags.vi;/,$RUST_SRC_PATH/.rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Auto-rustfmt on save
let g:autofmt_autosave = 1


" From https://stackoverflow.com/questions/6577579/task-tags-in-vim
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, BUG, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
  endif
endif

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Coffeescript syntax for cson files
au BufRead,BufNewFile *.cson set ft=coffee

" Remove highlighted search text after search/sed/etc...
nnoremap <esc> :noh<return><esc>
