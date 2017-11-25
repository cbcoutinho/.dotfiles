" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

set shell=/bin/bash
set nocompatible             	" be iMproved, required
" filetype off                  " required
set number			" Line numbers

if has('nvim')
	set termguicolors	" True color in neovim
endif

set textwidth=79 		" Set textwidth to <n> chars, wrap after that
set formatoptions+=t 		" Automatically wrap lines after <textwidth> chars
set formatoptions-=l 		" Already long lines will also be auto-wrapped if appended to
" Further, from the wiki:
" If you want to wrap lines in a specific area, move the cursor to the text you
" want to format and type gq followed by the range. For example, gqq wraps the
" current line and gqip wraps the current paragraph.

" Spell checking
set spell spelllang=en_us

" syntax on

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim/    " Location of VundleVim
" call vundle#begin('~/.vim/bundle')    " Where to install plugins

" NOTE: If using regular vim, change the target directory below to '.vim/autoload/plug.vim'
"auto-install vim-plug for vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

"auto-install vim-plug for nvim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'


" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plug 'rust-lang/rust.vim' 		" Rust stuff
Plug 'racer-rust/vim-racer'         	" Racer in vim

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdtree' 		" Project tree directory
Plug 'scrooloose/nerdcommenter' 	" Easily comment lines
Plug 'Xuyuanp/nerdtree-git-plugin'	" Git pluggin for NERDTree
Plug 'tpope/vim-fugitive'          	" Git plugin for vim
" All of your Plugins must be added before the following line
call plug#end()

let g:gruvbox_italic=1 	" Allows italics for gruvbox
colorscheme gruvbox
" colorscheme solarized
set background=dark 	" Options: [light/dark]

" Options for vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
