#!/bin/bash

backup_dirs=("/etc" "/srv" "/boot" "/home/prairiewaltz/Desktop" "/home/prairiewaltz/Downloads")
dest_dir="/tmp/backup"
dest_server="prairiewaltz@10.0.2.15"
backup_date=$(date +%b-%d-%Y-%H-%M-%S)

echo "Grabbing the backup of: ${backup_dirs[@]}"

for i in "${backup_dirs[@]}"; do
    y=$i
    i=$(echo -n $i | rev | cut -d "/" -f 1 | rev)
    sudo tar -Pczf /tmp/$i-$backup_date.tar.gz $y
    
    if [ $? -eq 0 ]; then
        echo "$y backup successful!"
    else
        echo "$y backup failed..."
    fi
    
    scp /tmp/$i-$backup_date.tar.gz $dest_server:$dest_dir
    if [ $? -eq 0 ]; then
        echo "$y Transfer successful!"
    else
        echo "$y Transfer failed..."
    fi
    
done

sudo rm /tmp/*.gz; echo "Backup Finished"

