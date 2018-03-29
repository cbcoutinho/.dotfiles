# we source the general profile here so we dont have to
# reimplement it
setopt nonomatch
source $HOME/.profile
unsetopt nonomatch
# put your own login shell specific configuration below
# this line

#if [ -x /usr/bin/fortune ] ; then
#	echo
#	/usr/bin/fortune
#	echo
#fi

# From:
#	https://github.com/robbyrussell/oh-my-zsh/issues/6106#issuecomment-309528254
#
# Enable gpg-agent if it is not running
#GPG_AGENT_SOCKET="/run/user/1000/gnupg/S.gpg-agent.ssh"
#if [ ! -S "$GPG_AGENT_SOCKET" ]; then
	#echo "inside loop"
  #gpg-agent --daemon >/dev/null 2>&1
  #export GPG_TTY=$(tty)
#fi

## Set SSH to use gpg-agent if it is configured to do so
#GNUPGCONFIG=${GNUPGHOME:-"$HOME/.gnupg/gpg-agent.conf"}
#if grep -q enable-ssh-support "$GNUPGCONFIG"; then
  #unset SSH_AGENT_PID
  #export SSH_AUTH_SOCK=$GPG_AGENT_SOCKET
#fi
