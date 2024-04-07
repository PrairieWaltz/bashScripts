#!/bin/bash

# Author: Basillica Bushnavel
# Date Created: This Day of Our Lord, Saturday the 6th and shit
# Last Modified: Time is an illusion, lasagna isn't
# Description: Backup all files in home directory
# Usage: run script when backup needed

echo " "
echo "Hi ${USER^}, Let's back-up your HOME(~) directory."
sleep 1s
## Add the default path you would like to save to ##
read -p "Is '**add your path here**' the right path? (y or n): " answer
sleep 1s
## Add the default name for this backup file ##
read -p "Is '**add name here**' the right name? (y or n) " answer2
echo "Thanks, give me just a second..."
sleep 1s

path_fn() {
    read -p "Please enter working path: " new_path
    echo $new_path
}

name_fn() {
    read -p "Please enter new name: " new_name
    echo $new_name
}

## Add default save path for vairiable ##
path_main=home/##YOURUSERNAME##/backUps
## Add default file name for variable ##
name_main=homeBackUpExample_

if [[ $answer == "y" && $answer2 == "y" ]];
then
    sudo tar -cvf /$path_main/$name_main"$(date +%d-%m-%y)".tar ~/* 2>/dev/null
    
elif [[ $answer == "n" && $answer2 == "n" ]];
then
    val1=$(path_fn)
    val2=$(name_fn)
    
    sudo tar -cvf "$val1"/"$val2"_"$(date +%d-%m-%y)".tar ~/* 2>/dev/null
    
elif [[ $answer == "y" && $answer2 == "n" ]];
then
    val2=$(name_fn)
    sudo tar -cvf /$path_main/"$val2"_"$(date +%d-%m-%y)".tar ~/* 2>/dev/null
    
elif [[ $answer == "n" && $answer2 == "y" ]];
then
    val1=$(path_fn)
    
    sudo tar -cvf "$val1"/$name_main"$(date +%d-%m-%y)".tar ~/* 2>/dev/null
else
    echo "Sorry, please try again with a working path or name"
    exit
fi

sleep 2s
echo "Directory Back-Up Complete!"
exit 0

