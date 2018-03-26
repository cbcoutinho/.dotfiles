#!/bin/bash
#
# Found in the offlineimap docs:
#	http://www.offlineimap.org/configuration/2016/01/29/why-i-m-not-using-maxconnctions.html#running-more-than-one-offlineimap-instance

offlineimap -a ChrisCoutinho & pid1=$!
offlineimap -a Work & pid2=$!

wait $pid1
wait $pid2
echo "Last execution: $(date)"
