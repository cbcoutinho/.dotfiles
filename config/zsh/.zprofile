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

# Notmuch
export NOTMUCH_CONFIG=~/.config/notmuch/config

# For clojure/clj CLI tools
export CLJ_CONFIG=~/.config/clojure/

# Leiningen directory
export LEIN_HOME=$HOME/.config/lein
