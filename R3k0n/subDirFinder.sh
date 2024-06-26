#!/bin/bash

# DEPENDENCIES:
# gobuster (sudo apt install gobuster)
# ffuf (sudo apt install ffuf)

# Get URL
echo -e "\n\033[32mLet's find some sub-Directories.\033[0m\nPlease enter a URL: "
read url
sleep .75

# Get save path
saveFolder=SubDirs
echo -e "\nPlease enter a path for saving your output files: "
read savePath
echo -e "\nOutput will be saved at $saveFiles/$saveFolder"
mkdir -p $savePath/$saveFolder
echo -e "Directory $saveFiles/$saveFolder created\n"
sleep .75

# Get Wordlist
echo -e "\nPlease enter a path to your preferred wordlist: "
read wordlist
echo -e "Using $wordlist\n"
sleep .75

# GOBUSTER
echo -e "Running gobuster on $url using wordlist at $wordlist\n"
gobuster dir -u $url -w $wordlist -o $savePath/$saveFolder/goBusterInitial.txt
echo -e "\n$(date +%b-%d-%Y-%H:%M)" >> $savePath/$saveFolder/goBusterInitial.txt
echo -e "Gobuster complete. File saved as goBusterInitial.txt\n"
sleep 1

# Get Wordlist ??
echo -e "\033[32mWould you like to use the same wordlist? (y or n): \033[0m"
read yorn
if [ $yorn != "y" ]; then
    echo -e "\nPlease enter a path to your preferred wordlist: "
    read wordlist;
else
    :
fi

echo -e "Using $wordlist\n"
sleep .75

# FFUF
echo "Running FFUF on $url using wordlist at $wordlist"
ffuf -u $url/FUZZ -mc all -fc 404 -c -t 50 -w $wordlist -o $savePath/$saveFolder/ffufInitial.json
cat $savePath/$saveFolder/ffufInitial.json | python -m json.tool | grep "FUZZ.:" > $savePath/$saveFolder/ffufInitial.txt
echo -e "\n$(date +%b-%d-%Y-%H:%M)" >> $savePath/$saveFolder/ffufInitial.json
echo -e "\n$(date +%b-%d-%Y-%H:%M)" >> $savePath/$saveFolder/ffufInitial.txt
# Uncomment below to automatically delete ffuf JSON file after parsing subDirectories
#rm $saveFiles/$saveFolder/ffufInitial.json
echo -e "FFUF complete. File(s) saved\n"
sleep 1

echo "Thanks. All done"
exit 0
