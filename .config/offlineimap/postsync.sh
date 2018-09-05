#!/bin/sh

# Based on the advice given:
#	https://kkatsuyuki.github.io/notmuch-conf/

notmuch new
notmuch tag -inbox +sent from:chrisbcoutinho@gmail.com
notmuch tag -inbox +sent from:cc162@humboldt.edu
notmuch tag -inbox +sent from:c.coutinho@redstack.nl
notmuch tag -inbox +sent from:ccoutinho@a-hak.nl
notmuch tag -inbox +promotions unsubscribe
