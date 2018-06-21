#!/usr/bin/env sh

# This script relies on the fact that a gpg-agent is running and has
# output its env file in ~/.gnupg/gpg-agent.env
# /etc/profile.d/gpg-agent.sh


# Throw away stdout, send stderr to shell/cron
if [ $(hostname) = 'tumbleweed' ]; then
	offlineimap -a ChrisCoutinho -u syslog >/dev/null & pid1=$!
	offlineimap -a Work -u syslog >/dev/null & pid2=$!

	wait $pid1
	wait $pid2
else
	offlineimap -a Work -u syslog >/dev/null
fi

# After syncing email using notmuch for indexing email
~/.config/offlineimap/postsync.sh

#[ $(declare -f count_new_msgs >/dev/null) ] && unset -f count_new_msgs
source $(dirname "$0")/count_new_msgs.sh

[ -d "$HOME/.mail/gmail" ] && gmail=$(count_new_msgs 'gmail')
[ -d "$HOME/.mail/office365" ] && office365=$(count_new_msgs 'office365')

#echo "gmail = $gmail"
#echo "office365 = $office365"

# NOTE: Unlike the ':-' operator that only compares and uses a default
# value, the ':=' operator sets the variable to the default value if
# missing
#	https://unix.stackexchange.com/a/122848/171562
if [ "${gmail:=0}" -gt 0 ] || [ "${office365:=0}" -gt 0 ]
then
	export DISPLAY=:0; export XAUTHORITY=~/.Xauthority;
	notify-send -i thunderbird -a 'OfflineIMAP' \
		'OfflineIMAP' "$(echo -e "New mail! Gmail: $gmail Office365: $office365")"
fi
