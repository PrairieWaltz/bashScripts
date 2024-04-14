#!/bin/bash

## Project to expand if/elif/else skill in scripts ##

echo
echo "Let's log us some memory data how'bout"
sleep 1
echo

file_creator() {
    echo
    echo "Creating memory data file..."
    sleep 2
    
    ## ------- LINUX/BASH line for free memory ------ ##
    free -m >> $HOME/performanceLogs/"$(date +%d-%m-%y)"_memory.log
    ## ------- WINDOWS line for free memory --------- ##
    #wmic OS get FreePhysicalMemory >> $HOME/performanceLogs/"$(date +%d-%m-%y)"_memory.log
    
    echo
    echo "File Created!"
}

if [ -d $HOME/performanceLogs ];
then
    echo "This folder exists. Awesome"
    sleep 1
    
    file_creator
else
    echo "I don't see that directory. Let's make it"
    sleep 1
    
    mkdir $HOME/performanceLogs
    
    echo "Working..."
    sleep 2
    echo "Directory has been created"
    sleep 1
    
    file_creator
fi

exit 0