#!/bin/bash

# Backup specified disks with bash command #

# "*" indicates value which is system dependent #


backup_dirs=("/*" "/*" "/*" "/home/*/Desktop" "/home/*/Downloads")
dest_dir="/tmp/backup"
dest_server="*@*"
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

