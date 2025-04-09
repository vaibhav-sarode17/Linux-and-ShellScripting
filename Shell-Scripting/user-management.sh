#!/bin/bash

# User management via shell scripting


function usage_info(){
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, -create     Create a new user account."
    echo "  -d, -delete     Delete an existing user account."
    echo "  -r, -reset      Reset password for an existing user account."
    echo "  -l, -list       List all user accounts on the system."
    echo "  -h, -help       Display this help."
}

function create_user(){
echo "Enter the new user name"
read username

if id $username &>/dev/null; then
        echo "$username already exist. Please try different user name"
else
        echo "user $username creating .."
        sudo useradd -m $username
        echo "Enter Password for user $username"
        sudo passwd $username
        echo "user $username created successfully"
fi
}

function delete_user(){
echo "Enter the user name which you want to delete"
read username

if id $username &>/dev/null;then
        echo "deleting user $username ..."
        sudo userdel -r $username
        echo "user $username deleted"
else
        echo "user $username not exist, please enter correct user name"
fi
}

function reset_password(){
echo "Enter the user name for changing password"
read username

if id $username &>/dev/null; then
        echo "changing the password for user $username "
        sudo passwd $username
        echo "Password has been changed for user $username "
else
        echo "user $username not exist, please enter correct user name"
fi
}

function list_user(){
echo "list all the available user in the system"
cat /etc/passwd | awk -F: '/sh/ {print $1, $3}'
}


if [ $# -eq 0 ]; then
        usage_info
        exit 0
fi


while [ $# -gt 0 ]; do
        case $1 in
        -c|-create)
                create_user
                ;;
        -d|-delete)
                delete_user
                ;;
        -r|-reset)
                reset_password
                ;;
        -l|-list)
                list_user
                ;;
        -h|-help)
                usage_info
                ;;
        *)
                echo "Error: Invalid option '$1'. Use '-h' or '-help' to see available options"
                exit 1
                ;;

esac
shift
done
