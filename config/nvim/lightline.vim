" Lightline {{{

" Extra `lightline` options found here:
" 	http://newbilityvery.github.io/2017/08/04/switch-to-lightline/
let g:lightline = {
			\	'colorscheme':'gruvbox',
			\	'active': {
			\		'left': [ ['mode', 'paste'],
			\			['cocstatus', 'gitbranch', 'readonly', 'filename', 'modified']
			\		],
			\	},
			\	'component': {
			\		'lineinfo': ' %3l:%-2v',
			\	},
			\	'component_function': {
			\		'gitbranch': 'fugitive#head',
			\		'cocstatus': 'coc#status'
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
