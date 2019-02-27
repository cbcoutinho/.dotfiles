#!/bin/sh

set -xe

# Locate and loop over all maildir directories
for dir in $(fd . ~/.mail --type directory --max-depth 1)
do
	tar -I pbzip2 \
		-cf ~/Dropbox/backups/$(date +%Y%m%d)-$(basename $dir).tbz2 \
		-C ~/.mail \
		$(basename $dir)
done
