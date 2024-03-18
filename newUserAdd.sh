#!/bin/bash

# Simple script to add a new user with encrypted password from list of preselected servers and check both if user already exists AND will call ERROR if user creation fails#

# System dependent variables demarcated with "*" #

# read list of preselected servers or use specific in line below #
servers=$(cat "*".txt)

read -p "Enter a username: " user
read -s -p "Enter a password: " pass
sleep 1

echo -e "\n"
echo "Thanks. Let's take a look"
echo -e "\n"
sleep 1

if grep "${user}" /etc/passwd >/dev/null 2>&1; then
    echo "This username already exists, please choose another"
    ./$(basename $0) && exit
fi

pw=$(perl -e 'print crypt($ARGV[0], "pass")' $pass)

for serv in $servers; do
    echo "Creating user $user on $serv"
    sudo useradd -m -p "$pw" "$user";
    if [ $? -eq 0 ]; then
        echo "New User added on $serv."
        echo "$user has been added to the system"
        echo "Current password will expire in 30 days"
        echo -e "\n"
    else
        echo "Error on SERVER $serv"
    fi
    
done