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
