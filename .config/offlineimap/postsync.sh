#!/bin/sh

# Based on the advice given:
#	https://kkatsuyuki.github.io/notmuch-conf/

notmuch new
notmuch tag -inbox +sent from:chrisbcoutinho@gmail.com
notmuch tag -inbox +sent from:c.coutinho@redstack.nl
notmuch tag -inbox +promotions unsubscribe