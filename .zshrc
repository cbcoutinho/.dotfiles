# Organizing this file drew inspiration from:
#	https://github.com/maximbaz/dotfiles

# Lazy-loading
source ~/.zsh/sandboxd.zsh

# My environment
source ~/.zsh/environment.zsh
source ~/.zsh/aliases.zsh

# `ls` function needs `less` alias
source ~/.zsh/functions.zsh

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
# eval `dircolors ~/.dir_colors/dircolors-solarized/dircolors.ansi-dark`
#eval "$(dircolors)"
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS
export CLICOLOR_FORCE="YES"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
