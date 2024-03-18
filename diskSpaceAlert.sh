#!/bin/bash

# Script to automatically measure current free space on specified disks and alert if a set capacity is reached #

# "*" indicates value which is system dependent #

filesystems=("*" "/*" "/*")
usageTotal=$(df -h / | tail -n 1 | awk '{print$*}' | cut -d % -f 1)
echo "Total usage is: $usageTotal%"
echo -e "\n"

for i in ${filesystems[@]}; do
    usage=$(df -h $i | tail -n 1 | awk '{print$*}' | cut -d % -f 1)
    
    if [ $usage -ge 70 ]; then
        alert="Low storage space on $i, usage is: $usage%"
        echo $alert
        echo "Sending out a disk space alert mail."
        echo -e "\n"
        #        echo $alert | mail.mailutils -s "$i is $usage% full. See to it" *@*
    fi
done

