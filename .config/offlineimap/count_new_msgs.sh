#!/usr/bin/env sh

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
		find $dir -type f #| wc -l
	done | awk 'BEGIN {total=0} {total+=1} END {print total}'
}

#[ -d "$HOME/.mail/gmail" ] && gmail=$(count_new_msgs 'gmail')
#[ -d "$HOME/.mail/office365" ] && office365=$(count_new_msgs 'office365')

#echo "gmail = $gmail"
#echo "office365 = $office365"
