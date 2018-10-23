#!/bin/zsh
# Based on
#	https://github.com/maximbaz/dotfiles/.zsh/sandboxd.zsh
# which was originally adapted from:
#	https://github.vom/benvan/sandboxd

# Start with an empty list of all sandbox cmd:hook pairs
sandbox_hooks=()

# deletes all hooks associated with cmd
function sandbox_delete_hooks() {
	local cmd=$1
	for i in "${sandbox_hooks[@]}";
	do
		if [[ $i == "${cmd}:"* ]]; then
			local hook=$(echo $i | sed "s/.*://")
			unset -f "$hook"
		fi
	done
}

# prepares environment and removes hooks
function sandbox() {
	local cmd=$1
	# NOTE: Use original grep, because aliased grep is using color
	if [[ "$(type $cmd | \grep -o function)" = "function" ]]; then
		(>&2 echo "Lazy-loading '$cmd' for the first time...")
		sandbox_delete_hooks $cmd
		sandbox_init_$cmd
	else
		(>&2 echo "sandbox '$cmd' not found.\nIs 'sandbox_init_$cmd() { ... }' defined and 'sandbox_hook $cmd $cmd' called?")
		return 1
	fi
}

function sandbox_hook() {
	local cmd=$1
	local hook=$2

	#echo "Creating hook ($2) for cmd ($1)"
	sandbox_hooks+=("${cmd}:${hook}")

	eval "$hook(){ sandbox $cmd; $hook \$@ }"
}


# RVM configuration
sandbox_init_rvm() {
	if [ -f ~/.rvm/scripts/rvm ]; then
		# Load `rvm`
		source ~/.rvm/scripts/rvm
	else
		echo 'To get `rvm` first softlink .rvmrc to $HOME, then'
		echo 'Execute the following to download `rvm`:'
		echo '	curl -sSL https://get.rvm.io | bash -s stable'
	fi
}

# Node Version Manager (NVM)
sandbox_init_nvm() {
	export NVM_DIR=~/Software/nvm
	if [ -d $NVM_DIR ]; then
		[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh
	else
		echo "You're trying to use 'nvm', but it's not installed"
	fi
}

sandbox_init_conda() {
	CONDA_ROOT=$HOME/Software/anaconda3
	if [ -d $CONDA_ROOT ]; then
		source $CONDA_ROOT/etc/profile.d/conda.sh
		conda activate
		#export PATH=$HOME/Software/anaconda3/bin:$PATH
	else
		echo "You're trying to use 'anaconda', but it's not installed"
	fi
}

# Don't load modules unless used
sandbox_hook rvm rvm

sandbox_hook nvm nvm
sandbox_hook nvm npm
sandbox_hook nvm node
sandbox_hook nvm yarn

# Anaconda
sandbox_hook conda conda
sandbox_hook conda conda-build
sandbox_hook conda conda-index
sandbox_hook conda conda-convert
