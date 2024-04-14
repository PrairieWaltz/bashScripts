#!/bin/bash

## Simple practice script to test working with "while getops" ##
## Accept user input for multiple variables and count back selected time in seconds ##

## Run command: ./egg_timer.sh -m ? -s ?

total_seconds=""
echo "--------------------"
while getopts "m:s:" opt;
do
    case $opt in
        m)
        total_seconds=$(($total_seconds + $OPTARG * 60));;&
        s)
        total_seconds=$(($total_seconds + $OPTARG));;
        ?);;
    esac
done

while [ $total_seconds -gt 0 ];
do
    echo $total_seconds
    total_seconds=$(($total_seconds - 1 ))
    sleep 1
done

echo
echo "Ding Ding!! Time's UP!!"
exit 0