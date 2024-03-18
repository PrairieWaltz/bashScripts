#!/bin/bash

# Simple script to add a new user with encrypted password #

read -p "Enter a username: " user
read -s -p "Enter a password: " pass
sleep 1

echo -e "\n"
echo "Thanks. Let's take a look"
sleep 1

pw=$(perl -e 'print crypt($ARGV[0], "pass")' $pass)

sudo useradd -m -p "$pw" "$user"

echo "$user has been added to the system"
echo "$user's password will expire in 30 days"