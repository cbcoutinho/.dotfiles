# If Current shell is an SSH connection, update gpg-agent tty

if [[ ! -z "$SSH_CONNECTION" ]] || [[ $(uname -r) =~ Microsoft$ ]]
then
	# Update gpg tty whenever I login
	gpg-connect-agent updatestartuptty /bye

fi

# Create systemd files if on WSL, and connect to drives
if [[ $(uname -r) =~ Microsoft$ ]]
then
	sudo systemd-tmpfiles --create >/dev/null 2>&1 && echo Created systemd-tmpfiles

	# Connecting network drives
	#/home/chris/bin/connect-drives
fi

# Assuming SSH is handled by GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
