#!/bin/bash

## Company onboarding script to collect new employee preferences and info ##
## Write info to .csv file ##

echo
echo "1) What is your first name?: "
read -p "First Name: " f_name
f_init=${f_name:0:1}
sleep .5
echo

echo "2) What is your last name?: "
read -p "Last Name: " l_name
l_init=${l_name:0:1}
sleep .5
echo

PS3="What type of telephone would you prefer?: "

select phone in Headset Handheld;
do
    echo
    sleep 1
    echo "You chose a $phone telephone"
    break
done
echo

PS3="What department are you working in?: "

select dept in Finance Sales "Customer Service";
do
    echo
    sleep 1
    echo "You selected the $dept department"
    break
done
echo

echo "3) What is your extension number?"
echo "(note: extension must be a 4 digit number)"
read -p "Extension: " ex_num

if (( ${#ex_num} != 4 ));
then
    echo "Extension must be 4 digits"
    read -p "Extension: " ex_num
fi

sleep .5
echo
echo "4) What access code would you like to use?: "
echo "(note: access code must be a 4 digit number)"
read -s -p "Access Code: " acc_code

if (( ${#acc_code} != 4 ));
then
    echo "Access Code must be 4 digits"
    read -s -p "Access Code: " acc_code
fi

### SAVE TO CSV ###
echo "$f_name,$l_name,$dept,$phone,$ex_num,$acc_code" > $HOME/onboarding/${f_name}.${l_init}_ext.csv
###################

echo
echo "Working..."
sleep 2
echo "Your info has been stored. Thanks"
echo

exit 0