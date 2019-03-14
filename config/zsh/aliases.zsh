# ayy lmao
alias qutebrowser="qutebrowser --backend webengine"
alias chromium="chromium --disk-cache-dir=/tmp/cache"

# ls aliases
alias ls="ls --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias l="ls -la"
alias exa="exa --group-directories-first"

# basic utils
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"

alias tree="tree -F -C"
# -F -> Appends '/', '=', '*', '@', '|' or '>' as per `ls -F`
# -C -> Turn colorize on

alias less="less -R -X -F"
# -R -> Output 'raw' ASCII control characters
# -X -> Do not use termcap init/deinit strings
# -F -> Quit if entire file fits on first screen

# prevents accidentally clobbering files
alias mkdir="mkdir -p"

# powerline test
alias testpl='echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"'

# Alias hub to git
command -v hub >/dev/null && eval "$(hub alias -s)"

# Hook direnv into the shell
command -v direnv >/dev/null && eval "$(direnv hook zsh)"


# OpenFOAM Aliases
if [[ -d $HOME/OpenFOAM ]]; then
	# Test if a directory similar to ~/OpenFOAM/OpenFOAM-5.x exists
	if test -n "$(find ~/OpenFOAM -maxdepth 1 -type d -name 'OpenFOAM-*' -print -quit)"
	then
		OF_DIR=$HOME/OpenFOAM
	else
		# If ~/OpenFOAM exists, but ~/OpenFOAM/OpenFOAM-* doesn't,
		# then OpenFOAM is probably in /opt
		OF_DIR=/opt/OpenFOAM
	fi
	alias ofdev="source $OF_DIR/OpenFOAM-dev/etc/bashrc"
	alias ofdevDebug="source $OF_DIR/OpenFOAM-dev/etc/bashrc WM_COMPILE_OPTION=Debug"
	alias of5x="source $OF_DIR/OpenFOAM-5.x/etc/bashrc"
	alias of5xDebug="source $OF_DIR/OpenFOAM-5.x/etc/bashrc WM_COMPILE_OPTION=Debug"
	alias of1806="source $OF_DIR/OpenFOAM-v1806/etc/bashrc"
	alias of1806Debug="source $OF_DIR/OpenFOAM-v1806/etc/bashrc WM_COMPILE_OPTION=Debug"
	alias of1812="source $OF_DIR/OpenFOAM-v1812/etc/bashrc"
	alias of1812Debug="source $OF_DIR/OpenFOAM-v1812/etc/bashrc WM_COMPILE_OPTION=Debug"
	alias ofplus="source $OF_DIR/OpenFOAM-plus/etc/bashrc"
	alias ofplusDebug="source $OF_DIR/OpenFOAM-plus/etc/bashrc WM_COMPILE_OPTION=Debug"
fi

if [[ -d $HOME/foam ]]; then
	alias fe40="source $HOME/foam/foam-extend-4.0/etc/bashrc"
	alias fe40Debug="source $HOME/foam/foam-extend-4.0/etc/bashrc WM_COMPILE_OPTION=Debug"
	alias fe41="source $HOME/foam/foam-extend-4.1/etc/bashrc"
	alias fe41Debug="source $HOME/foam/foam-extend-4.1/etc/bashrc WM_COMPILE_OPTION=Debug"
fi
