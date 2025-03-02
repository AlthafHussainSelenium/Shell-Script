#!/bin/bash

# Algarithm:
# 1. Set up colors code if we want to add any color to our messages
# 2. Write a method/function to validate the responces
# 3. Write a method/function to identify whether current user is a Root user or not
# 4. Insatll nginx
# 5. Enable and Start nginx
# 6. Remove existing code from the old version from nginx
# 7. Download latest code
# 8. Go to /usr/share/nginx/html
# 9. Unzip the downloaded file under tmp folder
# 10. Since vim cannot open in shell script automaticall we need to Copied expense config
# 11. Restarting nginx

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

CHECK_ROOT

dnf install nginx -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing Nginx Server"

systemctl enable nginx &>>$LOG_FILE_NAME
VALIDATE $? "Enabling Nginx server"

systemctl start nginx &>>$LOG_FILE_NAME
VALIDATE $? "Starting Nginx Server"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE_NAME
VALIDATE $? "Removing existing version of code"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE_NAME
VALIDATE $? "Downloading Latest code"

cd /usr/share/nginx/html
VALIDATE $? "Moving to HTML directory"

unzip /tmp/frontend.zip &>>$LOG_FILE_NAME
VALIDATE $? "unzipping the frontend code"

cp /home/ec2-user/Shell-Script/Config/expense.conf /etc/nginx/default.d/expense.conf
VALIDATE $? "Copied expense config"

systemctl restart nginx &>>$LOG_FILE_NAME
VALIDATE $? "Restarting nginx"
