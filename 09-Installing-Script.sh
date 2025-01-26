#!/bin/bash

# Algorithm
# Identify the current user is root user or not
# If user is root then allow to install
# else thow the error message and exit the script

USERID=$(id -u)
if [ $USERID -ne 0]; then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 # other than 0
fi
dnf install mysql -y
