# Organizing this file drew inspiration from:
#	https://github.com/maximbaz/dotfiles

# Aliases used in shell
source $ZDOTDIR/aliases.zsh

# `ls` function needs `less` alias
source $ZDOTDIR/functions.zsh

# Lazy-loading of commands
source $ZDOTDIR/sandboxd.zsh

# The user prompt (PS1)
source $ZDOTDIR/prompt.zsh

# Use pyenv to handle python in interactive shells
if command -v pyenv >/dev/null; then
	eval "$(pyenv init -)"
fi

# Python virtualenvwrapper
USER_BASE=$(python3 -c 'import site; print(site.USER_BASE)')
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_SCRIPT="$USER_BASE/bin/virtualenvwrapper.sh"
export PATH="$USER_BASE/bin:$PATH"

# NOTE: This assumes that virtualenvwrapper is installed
if command -v pyenv >/dev/null && grep -q system <(pyenv version); then
	source "$USER_BASE/bin/virtualenvwrapper_lazy.sh"
fi

# Jenv is like pyenv for java (on mac osx)
if command -v jenv >/dev/null; then
	export PATH="$HOME/.jenv/bin:$PATH"
	eval "$(jenv init -)"
fi

if command -v rbenv >/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# Pip zsh completions are already saved in $ZDOTDIR/.zfunc/_pip
# This line associates the completions with pip3 as well if available
if command -v pip3 >/dev/null; then
	compctl -K _pip_completion pip3
fi

#-------------------------------------------------------------
# options
#-------------------------------------------------------------

# Uncomment the following line if you want to disable marking untracked
# files under VCS as dirty. This makes repository status check for large
# repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# man page colours
export LESS_TERMCAP_mb=$'\e[0;31m'
export LESS_TERMCAP_md=$'\e[0;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;34;36m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;35m'

#-------------------------------------------------------------
# aliases
#-------------------------------------------------------------

export COLUMNS  # Remember columns for subprocesses.
eval "$(dircolors)"

#-------------------------------------------------------------
# zsh options
#-------------------------------------------------------------

# vim mode
bindkey -v

# Extra stuff from
#	https://dougblack.io/words/zsh-vi-mode.html
#bindkey '^P' up-history
#bindkey '^N' down-history
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
#bindkey '^r' history-incremental-search-backward
#
#function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
#export KEYTIMEOUT=1

# string comparison in bash doesn't work in zsh if EQUALS is set
# 	https://www.zsh.org/mla/users/2011/msg00161.html
unsetopt EQUALS


# colours from neovim/gruvbox - assumes nvim has installed gruvbox
# package
if [[ -d ~/.local/share/nvim/plugged/gruvbox ]]; then
	source ~/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh
else
	echo "Gruvbox not found, download via 'nvim'"
fi


#.# zsh-syntax-highlighting
#
# Fish shell like syntax highlighting for Zsh
#
# @link: http://github.com/zsh-users/zsh-syntax-highlighting
file=$(find ~/Software /usr/share /usr/local/share -name 'zsh-syntax-highlighting.zsh' 2>/dev/null)
if [[ -f $file ]]; then
	source $file
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

	# To have commands starting with `rm -rf /` in red:
	ZSH_HIGHLIGHT_PATTERNS=('rm -rf /*' 'fg=white,bold,bg=red')
fi

#.# zsh-autosuggestions
#
# Fish-like fast/unobtrusive autosuggestions for zsh.
#
# @link: http://github.com/zsh-users/zsh-autosuggestions
file=$(find ~/Software /usr/share /usr/local/share -name 'zsh-autosuggestions.zsh' 2>/dev/null)
if [[ -f $file ]]; then
	source $file
fi

# Append personal zsh-completions to fpath
fpath=(
	$ZDOTDIR/completions
	/usr/local/share/zsh-completions
	/etc/zsh_completion.d
	$fpath
)

# completions
autoload -Uz compinit && compinit -i
compinit -i

# Sources aws completion if exists
file=$(find /usr/local/share -name 'aws_zsh_completer.sh')
if [[ -f $file ]]; then
	source $file
fi

for file in $(find /usr/etc /usr/local -regextype posix-extended -regex '.*(nvm|az)$')
do
	if [[ -f $file ]]; then
		# Add bash completion for some bash-only completion scripts
		autoload -U +X bashcompinit && bashcompinit
		source $file
	fi
done

# Allow dot files to match on tab completion
#	https://unix.stackexchange.com/a/308322/171562
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt COMPLETE_ALIASES

# history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt EXTENDED_HISTORY # Logs the start
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

unsetopt beep

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
