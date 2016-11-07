#!/bin/bash
#
# Lists start and end of each log file
#
# Author Mark Curtis, 2015 Jul 08
#

# Enter your date string here
searchStr="2016-[0-9]*-[0-9]*.[0-9]*:[0-9]*:[0-9]*,[0-9]*"

function checkForFiles {
    # validate we can find at least 1 file
    files=$(find . -name "$1" -type f)

    # check if no files found
    if [ -z "$files" ]
    then
        echo "Couldn't find any files named $1 from here. Exiting"
        exit 1
    fi

    # get the first directory
    for file in $files
    do
        node0=$file
        break
    done
}

# Check for the files first
checkForFiles "*system.log*"

# validate we can find at least 1 file
if [ -r $node0 ]
then
    # at least 1 file is readable
    echo "===== `basename $0` ====="
else
    echo "Unable to find any files named $node0"
    exit 1
fi

# iterate through all logs
for logfile in $files
do
    grep -Ho $searchStr $logfile | head -1 | awk '{print "START: "$0}'
    grep -Ho $searchStr $logfile | tail -1 | awk '{print "END  : "$0}'
    echo ""
done
