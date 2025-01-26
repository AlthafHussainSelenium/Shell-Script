#!/bin/bash

# Algorithm ####
# Identify the current user is root user or not
# If user is root then allow to install
# else thow the error message and exit the script
# check whether the package already installed
# if not installed
# then install the package
# if the installation is not successful
# then exit the script
# else print the package installation is successful
# else print the package already installed

USERID=$(id -u)
echo "User Id is ... $USERID"
if [ $USERID -ne 0 ]; then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 # other than 0
fi
dnf remove mysql -y
echo "my sql removal output is ... $?"
dnf list installed mysql
echo "Previous list installed command mysql output is ... $?"
if [ $? -ne 0 ]; then # not installed
    dnf install mysql -y
    echo "Previous install command mysql output is ... $?"
    if [ $? -ne 0 ]; then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi

dnf list installed git
echo "Previous command git output is ... $?"
if [ $? -ne 0 ]; then
    dnf install git -y
    if [ $? -ne 0 ]; then
        echo "Installing Git ... FAILURE"
        exit 1
    else
        echo "Installing Git ... SUCCESS"
    fi
else
    echo "Git is already ... INSTALLED"
fi
