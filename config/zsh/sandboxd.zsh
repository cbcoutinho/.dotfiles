#!/usr/bin/env zsh
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


# Node Version Manager (NVM)
sandbox_init_nvm() {
	if [[ $(uname -s) == "Darwin" ]] || command -v brew >/dev/null; then
		# This assumes 'nvm' is already installed via brew
		export NVM_DIR=$HOME/.nvm
		source $(brew --prefix nvm)/nvm.sh
	elif [ -d "${NVM_DIR:-$HOME/Software/nvm}" ]; then
		[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh && export NVM_DIR
	else
		echo "You're trying to use 'nvm', but it's not installed"
	fi
}

sandbox_hook nvm nvm
sandbox_hook nvm npm
sandbox_hook nvm npx
sandbox_hook nvm node
sandbox_hook nvm yarn
sandbox_hook nvm sfdx
sandbox_hook nvm fast
