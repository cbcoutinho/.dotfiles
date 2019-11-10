# If Current shell is an SSH connection, update gpg-agent tty

if [[ ! -z "$SSH_CONNECTION" ]] || [[ $(uname -s) == "Darwin" ]]
then
	# Update gpg tty whenever I login
	# FIXME: Why is this not needed on openSUSE?
	gpg-connect-agent updatestartuptty /bye

fi

# Assuming SSH is handled by GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

# My environment
source $ZDOTDIR/environment.zsh
