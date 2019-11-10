" Make sure to slink this to ~/.vimrc (for vim) and ~/.config/nvim/init.vim (for neovim)

let g:config_file_list = [
			\  'shell.vim',
			\  'plugins.vim',
			\  'settings.vim',
			\  'colors.vim',
			\  'lightline.vim',
			\  'slime.vim',
			\  'vlime.vim',
			\  'vimwiki.vim',
			\  'functions.vim',
			\  'keymaps.vim'
			\]

for file in g:config_file_list
	exec 'source' . stdpath('config') . '/' . file
endfor
