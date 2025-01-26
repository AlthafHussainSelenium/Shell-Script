#!/bin/bash

# Algorithm ####
# Identify the current user is root user or not
# If user is root then allow to install
# else thow the error message and exit the script

# USERID=$(id -u)
# if [ $USERID -ne 0 ]; then
#     echo "ERROR:: You must have sudo access to execute this script"
#     exit 1 # other than 0
# fi
dnf list installed mysql

if [ $? -ne 0 ]; then # not installed
    dnf install mysql -y
    if [ $? -ne 0 ]; then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi
