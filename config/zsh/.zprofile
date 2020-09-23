# we source the general profile here so we dont have to
# reimplement it
setopt nonomatch
source $HOME/.profile
unsetopt nonomatch
# put your own login shell specific configuration below
# this line

if [ -x /usr/bin/fortune ] ; then
	echo
	/usr/bin/fortune
	echo
fi

# My environment
source $ZDOTDIR/environment.zsh

# GPG Auth for SSH
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
