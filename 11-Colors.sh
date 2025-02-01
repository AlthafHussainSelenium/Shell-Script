#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m]"
Y="\e[33m]"

# Method to validate
VALIDATE() {
    if [ $1 -ne 0]; then
        echo -e $2 ... $R FAILURE
    else
        echo -e $2 ... $G SUCCESS
    fi
}

# Verify Root user or not script
if [ $USERID -ne 0 ]; then
    echo "ERROR:: You must have sudo access to execute this script"
    exit 1 # other than 0
fi

# validate if the software is already installed or not
dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    validate $? "Installing MySQL"
else
    echo -e "MySQL is already ... $Y INSTALLED"
fi
