#!/bin/bash

## Set up a folder structure for a shared network drive, using a file to read paths from txt file ##
## Create a script that will read the txt file, and create all these folders ##

path="$HOME/folderTest"
echo

while read line;
do
    echo "Working..."
    sleep 1
    mkdir "$path/$line"
    echo "Directory created: $line"
    echo
done < "$1"

exit 0
