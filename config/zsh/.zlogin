# Update gpg tty whenever I login
gpg-connect-agent updatestartuptty /bye

# Assuming SSH is handled by GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
