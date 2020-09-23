# If Current shell is an SSH connection, update gpg-agent tty
if [[ ! -z "$SSH_CONNECTION" ]] || [[ $(uname -s) == "Darwin" ]]
then
	# Update gpg tty whenever I login
	# FIXME: Why is this not needed on openSUSE?
	gpg-connect-agent updatestartuptty /bye

fi
