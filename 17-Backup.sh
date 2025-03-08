#!/bin/bash

# This test is to identify the past logs for cetain duration, and keeping them in a folder by zipping

# Algarithm:
# Set up colors code if we want to add any color to our messages
# Write a method/function to validate the responces
# Write a method/function to identify whether current user is a Root user or not
# Write a method/function to chech the usage of the backup file
# Form the log file name
# Create a logs folder
# Verify Source and Destination directory is exists or throw the error
# Install Zip in the server
# Create some log files in source directory
# Verify if the files are exist,
# if Yes zip the files and verify zip is successful then delete all individual files.
# If zip is not successful then throw the error

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_FOLDER=$1
DEST_FOLDER=$2
DAYS=${3:-14} # if user is not providing number of days, we are taking 14 as default

LOG_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(find echo $0 | awk -F "/" '{pint $NF}' | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIME_STAMP.log"

VALIDATE() {
    if [ $1 -ne 0]; then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

USERID=$(id -u)

CHECK_ROOT() {
    if [ $USERID -ne 0]; then
        echo "ERROR:: You must have sudo access to execute this script"
        exit 1 #other than 0
    fi
}

USAGE() {
    echo -e "$R USAGE:: $N backup <SOURCE_DIR> <DEST_DIR> <DAYS(Optional)>"
    exit 1
}

mkdir -p "$LOG_FOLDER"

if [ $# - 2]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$SOURCE_DIR Does not exist...Please check"
    exit 1
fi

if [ ! -d $DEST_DIR]; then
    echo -e "$DEST_DIR Does not exist...Please check"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

dnf list installed zip
if [ $? -ne 0]; then
    echo -e "$R ZIP Is Not Installed $N"
    dnf install zip -y
    VALIDATE $? " ZIP Installation "
else
    echo -e "$G ZIP Is Already Installed"
fi

CREATEFILES() {
    for i in 0 1 2 3 4 5; do
        touch "$i-$TIME_STAMP.log"
    done
}

CREATEFILES

FILES=$(find $SOURCE_DIR -name "*.log" -mtime $DAYS)

if [ -n $FILES ]; then
    echo "Files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    $FILES | zip -@ "$ZIP_FILE"
    if [ -f $ZIP_FILE ]; then
        echo -e "Successfully created zip file for files older than $DAYS"
        while read -r filepath; do # here filepath is the variable name, you can give any name
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<<$FILES
    else
        echo -e "$R Error:: $N Failed to create ZIP file "
        exit 1
    fi

else
    echo "No files found older than $DAYS"
fi
