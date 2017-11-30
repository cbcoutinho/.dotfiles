" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

set shell=/bin/bash         " Force shell to use bash
set nocompatible            " Be iMproved, required for (n)vim
set number                  " Line numbers

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
elseif has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLORS=1
endif

set textwidth=79 		    " Set textwidth to <n> chars, wrap after that
set formatoptions+=t        " Automatically wrap lines after <textwidth> chars
set formatoptions-=l        " Already long lines will also be auto-wrapped if appended to
" Further, from the wiki:
" If you want to wrap lines in a specific area, move the cursor to the text you
" want to format and type gq followed by the range. For example, gqq wraps the
" current line and gqip wraps the current paragraph.
if executable('par')        " See 'par' vimcast for amazing text wrangler
    set formatprg=par
endif

" Spell checking
set spell spelllang=en_us
au BufNewFile,BufRead .shrc set filetype=sh     " Sets .shrc files to use sh syntax

if has('nvim')
	"echo "I'm nvim"
	let plugfile = '~/.local/share/nvim/site/autoload/plug.vim'
	let plugin_dir = '~/.local/share/nvim/plugged'
else
	"echo "I'm vim"
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
Plug 'rust-lang/rust.vim'           " Rust stuff
Plug 'racer-rust/vim-racer'         " Racer in vim
if has('nvim-0.1.5')
    Plug 'snoe/nvim-parinfer.js'    " Lisp parens auto-adjust for nvim 0.1.5+
else
    Plug 'bhurlow/vim-parinfer'     " Vim port of nvim-parinfer.js
endif

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'         " Syntax highlighting for different languages

Plug 'scrooloose/nerdtree'          " Project tree directory
Plug 'scrooloose/nerdcommenter'     " Easily comment lines
Plug 'Xuyuanp/nerdtree-git-plugin'  " Git plugin for NERDTree
Plug 'tpope/vim-fugitive'           " Git plugin for vim
Plug 'airblade/vim-gitgutter'       " Git status in gutter (next to line numbers)
Plug 'itchyny/lightline.vim'        " Status line for vim

" All of your Plugins must be added before the following line
call plug#end()

colorscheme gruvbox
let g:gruvbox_italic=1 	" Allows italics for gruvbox
set background=dark 	" Options: [light/dark]
let g:lightline = {'colorscheme':'onedark'}

"colorscheme solarized
"set background=dark 	" Options: [light/dark]
"let g:lightline = {'colorscheme':'solarized'}

"colorscheme onedark
"let g:onedark_terminal_italics=1 	" Allows italics for onedark
"let g:lightline = {'colorscheme':'onedark'}

set noshowmode          " Status is already in lightline - no need for redundency

" Options for vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
