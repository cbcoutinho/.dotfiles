# Organizing this file drew inspiration from:
#	https://github.com/maximbaz/dotfiles

# Lazy-loading
source ~/.zsh/sandboxd.zsh

# My environment
source ~/.zsh/environment.zsh
source ~/.zsh/aliases.zsh

# `ls` function needs `less` alias
source ~/.zsh/myfunctions.zsh

# The user prompt (PS1)
source ~/.zsh/prompt.zsh

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


# colours from neovim/gruvbox - assumes nvim has installed gruvbox
# package
if [ -d ~/.local/share/nvim/plugged/gruvbox ]; then
	source ~/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh
else
	echo "Gruvbox not found, download via 'nvim'"
fi


#.# zsh-syntax-highlighting
#
# Fish shell like syntax highlighting for Zsh
#
# @link: http://github.com/zsh-users/zsh-syntax-highlighting
if [ -d ~/Software/zsh-syntax-highlighting ]; then
	source ~/Software/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

	# To have commands starting with `rm -rf /` in red:
	ZSH_HIGHLIGHT_PATTERNS=('rm -rf /*' 'fg=white,bold,bg=red')
fi

#.# zsh-autosuggestions
#
# Fish-like fast/unobtrusive autosuggestions for zsh.
#
# @link: http://github.com/zsh-users/zsh-autosuggestions
if [ -d ~/Software/zsh-autosuggestions ]; then 
	source ~/Software/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Shell completions (rust, cargo, and hub)
fpath+=~/.zfunc
if [ -d ~/Software/zsh-completions ]; then
	fpath+=~/Software/zsh-completions/src
else
	echo "	The 'zsh-completions' package was not found"
fi

# completions
autoload -Uz compinit && compinit
compinit

# Allow dot files to match on tab completion
#	https://unix.stackexchange.com/a/308322/171562
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt COMPLETE_ALIASES

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS


# Log commands to rsyslog for future reference
#	To use system-wide, copy the following to /etc/zshrc
#precmd() { eval 'RETRN_VAL=$?;logger -p local6.debug "$(whoami) [$$]: $(history | tail -n1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"' }
