# Update gpg tty if SSH_CONNECTION exists (is non-zero length)
[ ! -z "${SSH_CONNECTION}" ] && gpg-connect-agent updatestartuptty /bye

export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
