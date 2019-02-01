# If Current shell is an SSH connection, update gpg-agent tty

if [[ ! -z "$SSH_CONNECTION" ]] || [[ $(uname -r) =~ Microsoft$ ]]
then
	# Update gpg tty whenever I login
	gpg-connect-agent updatestartuptty /bye

	# Assuming SSH is handled by GPG
	export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
fi

sudo systemd-tmpfiles --create >/dev/null 2>&1 && echo Created systemd-tmpfiles

# Connecting network drives
/home/chris/bin/connect-drives
