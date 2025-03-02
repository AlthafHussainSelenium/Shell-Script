#!/bin/bash

# Algarithm:
# 1. Set up colors code if we want to add any color to our messages
# 2. Write a method/function to validate the responces
# 3. Write a method/function to identify whether current user is a Root user or not
# 4. Disable node js version and enale our desired version e.g., 20
# 5. Install Node js
# 6. Add user as expense or as per our requirement
# 7. Create app directory
# 8. Download the application code to created app directory.
# 9. Go to app directory
# 10. Unzip the downloaded file under tmp folder
# 11. Install dependencies using npm install it will install all the dependencies from the package.json file
# 12. Load the service using daemon-reload
# 13. Start the backend server then enable it
# 14. We need to load the schema. To load schema we need to install mysql client. And Load Schema
# 15. Restart backend server

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

CHECK_ROOT

# Making a Log file path and save it
LOG_FOLDER="/var/log/expense-logs"

# verify if the logs directory is exist or not, if not then create
if [ ! -d $LOG_FOLDER ]; then
    echo -e "$R Folder is not Exist $N"
    mkdir $LOG_FOLDER
    VALIDATE $? "Creating expense-logs Folder is "
fi

LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

dnf module disable nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "Disabling nodejs is"
