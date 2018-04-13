# we source the general profile here so we dont have to
# reimplement it
setopt nonomatch
source $HOME/.profile
unsetopt nonomatch
# put your own login shell specific configuration below
# this line

# Tmux has trouble accessing the gpg-agent otherwise
#	https://unix.stackexchange.com/a/334326/171562
export GPG_TTY=${TTY}

if [ -x /usr/bin/fortune ] ; then
	echo
	/usr/bin/fortune
	echo
fi

# From:
#	https://github.com/robbyrussell/oh-my-zsh/issues/6106#issuecomment-309528254
#
# Enable gpg-agent if it is not running
#GPG_AGENT_SOCKET=$(gpgconf --list-dirs agent-socket)
#if [ ! -S "$GPG_AGENT_SOCKET" ]; then
#	gpg-agent --daemon --enable-ssh-support >/dev/null 2>&1
#	export GPG_TTY=$(tty)
#fi

## Set SSH to use gpg-agent if it is configured to do so
#GNUPGCONFIG=${GNUPGHOME:-"$(gpgconf --list-dirs homedir)/gpg-agent.conf"}
#if grep -q enable-ssh-support "$GNUPGCONFIG"; then
#	unset SSH_AGENT_PID
#	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#fi

#gpg-connect-agent /bye
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpg-connect-agent reloadagent updatestartuptty /bye
