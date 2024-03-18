#!/bin/bash

# Simple Password Manager #
# Store encrypted passwords for backup | decrypt with user specified password #

### OPTIONS ###
## LIST - Show all files currently stored - accepts one variable
## ---> usage: $ ./tinyPass+PM.sh list

## INSERT - Create a new encrypted file/password - accepts two variables
## ---> usage: $ ./tinyPass+PM.sh insert [new file name]

## SHOW - Displays encrypted file in plain text for correct user/pass
## ---> usage: $ ./tinyPass+PM.sh show [existing file name]

# This script is for practice and testing only. Not intended for use in a production environment. #

######################## --> Allow permission for owner only <-- ########################
umask 077

####################################### VARIABLES #######################################
GPG_OPTS="--quiet --yes --batch"
STORE_DIR="${HOME}/.password_STORE"

##################################### Abort Function ### ################################
abort() {
    printf '%s\n' "${1}" 1>&2
    exit 1
}

##################################### Encrypt Function ###################################
gpg() {
    gpg2 $GPG_OPTS --default-recipient-self "$@"
}

##################################### Password Reader #####################################
readpw() {
    # check user shell interaction, no daemons or programs calling this app #
    if [ -t 0 ]; then
        echo -n "Enter password for ${entry_name}:"
        read -s password
    fi
}
######################################### COMMANDS ########################################
### INSERT ###
insert() {
    entry_name="${1}"
    entry_path="${STORE_DIR}/${entry_name}.gpg"
    
    if [ -z "${entry_path}" ]; then
        abort "USAGE: tinyPass insert PROFILENAME"
    fi
    
    if [ -e "${entry_path}" ]; then
        abort "This entry or password profile already exists"
    fi
    
    readpw "Password for '${entry_name}': " password
    if [ -t 0 ]; then
        printf '\n'
    fi
    
    if [ -z "${password}" ]; then
        abort "Please specify a password"
    fi
    
    mkdir -p "${entry_path%/*}"
    printf '%s\n' "${password}" | gpg2 --encrypt --output "${entry_path}"
}

### SHOW ###
show() {
    entry_name="${1}"
    entry_path="$STORE_DIR/${entry_name}.gpg"
    
    if [ -z "${entry_name}" ]; then
        abort "USAGE: tinyPass show PROFILENAME"
    fi
    
    if [ ! -e "${entry_path}" ]; then
        abort "Requested PASSWORD profile does not exist"
    fi
    
    gpg --decrypt "${entry_path}"
    
}

### LIST ###
list() {
    for i in $(ls $STORE_DIR); do echo $i;
    done
    
}

####################################### MAIN PROGRAM ######################################
if [ "$#" -gt 2 ]; then
    abort "tinyPass will not work with more than 2 arguments"
fi

if [ "$#" -lt 1 ]; then
    abort "USAGE: tinyPass COMMAND PROFILENAME"
fi

case "${1}" in
    "show") show "${2}" ;;
    "list") list ;;
    "insert") insert "${2}" ;;
    *)
    abort "USAGE: tinyPass COMMAND PROFILENAME" ;;
esac
