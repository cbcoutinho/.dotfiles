#!/bin/sh
#
# A `display_filter` in mutt is called before displaying a message. We
# can cleverly build up our alias file by parsing these messages.
# Source:
#	http://wcm1.web.rice.edu/mutt-tips.html

MESSAGE=$(cat)

#AWK='{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) '
#AWK+='{print "alias" $0 $0;} else if (NF > 3) {print "alias", '
#AWK+='tolower($(NF-1))"-"tolower($2) $0;}}'
#NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | sed s/[\,\"\']//g | awk $AWK)

NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | sed s/[\,\"\']//g | awk '{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) {print "alias" $0 $0;} else if (NF > 3) {print "alias", tolower($(NF-1))"-"tolower($2) $0;}}')

if grep -Fxq "$NEWALIAS" $HOME/.config/mutt/alias; then
    :
else
    echo "$NEWALIAS" >> $HOME/.config/mutt/alias
fi

echo "${MESSAGE}"
