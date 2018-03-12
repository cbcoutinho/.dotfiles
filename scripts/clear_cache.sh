#!/bin/sh
# This shell script was originally found on this
# unix.stackexchange.com answer:
#	https://unix.stackexchange.com/a/87909/171562
sudo sh -c 'free && sync && echo 3 > /proc/sys/vm/drop_caches && free'
