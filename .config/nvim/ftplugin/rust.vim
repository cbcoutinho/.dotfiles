" Rust specific settings

" Options for vim-racer
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap <leader>gd <Plug>(rust-doc)

" For rusty-tags support in rust files using vim
" Requires the `universal-ctags` package to be installed
" NOTE: Format is set in ~/.rusty-tags/config.toml
setlocal tags+=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Auto-rustfmt on save. Make sure to have rustfmt installed
"	rustup component add rustfmt-preview
let g:rustfmt_autosave = 1

" related to w0rp/ale plugin
let b:ale_linters = {'rust': ['rls', 'cargo', 'rustc']}
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_completion_enabled = 1
