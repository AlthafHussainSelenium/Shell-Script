#!/bin/bash

# Algarithm:
# 1. Set up colors code if we want to add any color to our messages
# 2. Write a method/function to validate the responces
# 3. Write a method/function to identify whether current user is a Root user or not
# 4. Create few .log files with a loop
# 5. Identify the log files which is from last 14 days then delete

# This is to get the root user output
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

CHECK_ROOT() {
    if [ $USERID -ne 0 ]; then
        echo "ERROR:: You must have sudo access to execute this script"
        exit 1 #other than 0
    fi
}

CREATEFILES() {
    for i in {0..10}; do
        touch "$1/$2.log"
    done
    echo "list of the file are :: "
    ls "$1"

}

CHECK_ROOT

# Making a Log file path and save it
LOG_FOLDER="/var/log/expense-logs"
DAYS="14"

# verify if the logs directory is exist or not, if not then create
if [ ! -d $LOG_FOLDER ]; then
    echo -e "$R Folder is not Exist $N"
    mkdir $LOG_FOLDER
    VALIDATE $? "Creating expense-logs Folder is "
else
    echo -e "$R Folder is already Exist $N"
fi

LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"
CREATEFILES $LOG_FOLDER $TIMESTAMP

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES_TO_DELETE=$(find $LOG_FOLDER -name "*.log" -mtime "+$DAYS")
echo "Files to be deleted: $FILES_TO_DELETE"
