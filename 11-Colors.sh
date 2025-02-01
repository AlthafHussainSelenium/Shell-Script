#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m]"
Y="\e[33m]"
N="\e[0m"

# Method to validate
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N"
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

# Verify Root user or not script
if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: You must have sudo access to execute this script $N"
    exit 1 # other than 0
fi

# Remove the software if already it is installed
dnf list installed mysql
if [ $? -eq 0 ]; then
    dnf remove mysql -y
    VALIDATE $? "Un-Installing MySQL"
fi

# validate if the software is already installed or not
dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo -e "MySQL is already ... $Y INSTALLED $N"
fi
