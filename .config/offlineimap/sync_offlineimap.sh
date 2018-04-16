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

# Using `while read` instead of `for`:
#	https://stackoverflow.com/a/9612560/5536001
# Using awk to total output:
#	https://stackoverflow.com/a/13728129/5536001
# Correctly turn off spaces and globing in shell
#	https://unix.stackexchange.com/a/9500/171562

function count_new_msgs {
	# The function counts the number of new messages, which based on
	# the 'Maildir' directory format are contained in a 'new'
	# subdirectory.
	# This function expects to have a mailbox name as input and
	# returns the number of new messages.

	# IFS needs to be overridden
	IFS='
	'
	set -f
	for dir in $(find $HOME/.mail/$1 -not \( -path "$HOME/.mail/$1/Drafts" -prune \) -name 'new')
	do
		find $dir -type f | wc -l
	done | awk '{total += $1} END {print total}'
}

gmail=$(count_new_msgs 'gmail')
office365=$(count_new_msgs 'office365')

if [ $gmail -gt 0 ] || [ $office365 -gt 0 ]
then
	export DISPLAY=:0; export XAUTHORITY=~/.Xauthority;
	notify-send -i thunderbird -a 'OfflineIMAP' \
		'OfflineIMAP' "$(echo -e "New mail! Gmail: $gmail Office365: $office365")"
fi
