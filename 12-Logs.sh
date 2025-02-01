#!/bin/bash

USERID=$(id -u) # it will give us root user id
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1) # $0 will return script name
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

# Method to validate
VALIDATE() {
    if [ $1 -ne 0]; then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi

    echo "Script started execution at: $TIMESTAMP &>>$LOG_FILE_NAME"

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
}
