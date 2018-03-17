
# Python path
alias ana="export PATH=$HOME/anaconda3/bin:$PATH"

# ayy lmao
alias qutebrowser="qutebrowser --backend webengine"
alias chromium="chromium --disk-cache-dir=/tmp/cache"
alias vi="nvim"
alias vim="nvim"

# ls aliases
alias ls="ls --group-directories-first"
alias ll="ls -l"
alias l="ls -l -a"
alias exa="exa --group-directories-first"

# basic utils
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias tree="tree -a -I '.git' -F"

# prevents accidentally clobbering files
alias mkdir="mkdir -p"

# powerline test
alias testpl='echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"'

# Alias hub to git
command -v hub >/dev/null && eval "$(hub alias -s)"

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
	alias ofdev="source $OF_DIR/OpenFOAM-dev/etc/bashrc $FOAM_SETTINGS"
	alias of5x="source $OF_DIR/OpenFOAM-5.x/etc/bashrc $FOAM_SETTINGS"
	alias of4x="source $OF_DIR/OpenFOAM-4.x/etc/bashrc $FOAM_SETTINGS"
	alias of30x="source $OF_DIR/OpenFOAM-3.0.x/etc/bashrc $FOAM_SETTINGS"
	alias of1712="source $OF_DIR/OpenFOAM-v1712/etc/bashrc $FOAM_SETTINGS"

	alias fe40="source $HOME/foam/foam-extend-4.0/etc/bashrc"
fi
