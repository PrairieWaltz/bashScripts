#!/bin/bash

# Simple Bash Script to add new user to pre-chosen list of servers with UID #
# NO password created, no checks for existing users, ERROR if creation fails #

# System dependant variables demarcared with "*" #

# Read from file or add destination server below #
servers=$(cat "*".txt)

echo -n "Enter username please: "
read user
echo -n "Enter your UID: "
read uid

for serv in $servers; do
    echo "Creating user $user on $serv with UID $uid"
    #sudo useradd -m -u "$uid" "$user";
    ssh $serv -S "sudo useradd -m -u $uid $user";
    if [ $? -eq 0 ]; then
        echo "User $user added on $serv."
    else
        echo "Error on SERVER $serv"
    fi
    
done