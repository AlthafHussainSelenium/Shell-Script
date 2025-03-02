#!/bin/bash

# Algarithm:
# 1. Set up colors code if we want to add any color to our messages
# 2. Write a method/function to validate the responces
# 3. Write a method/function to identify whether current user is a Root user or not
# 4. Install My SQL Server and Enable then Start the server
# 5. We need to change the default root password in order to start using the database service. Use password ExpenseApp@1 or any other as per your choice.
# 6. Verify whether the data base is connecting or not e.g., mysql -h <host-address> -u root -p<password>
# 7. Once we connected to DB then verify the Data bases e.g., show databases; use databases <name of the DB>
# 8. Once you are in particular schema, you can get the list of tables. e.g., show tables; select * from <table_name>;

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

nf list installed mysqld

if [ $? -eq 0 ]; then # not installed
    dnf remove mysql-server -y &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]; then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi

dnf install mysql-server -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOG_FILE_NAME
VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOG_FILE_NAME
VALIDATE $? "Starting MySQL Server"

# This command will set the root password once it is successfull then it will show the databases
mysql -h mysql.atzuk.space -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE_NAME

# if the root password was set then use below code
if [ $? -ne 0 ]; then
    echo "MySQL Root password not setup" &>>$LOG_FILE_NAME
    mysql_secure_installation --set-root-pass ExpenseApp@1
    VALIDATE $? "Setting Root Password"
else
    echo -e "MySQL Root password already setup ... $Y SKIPPING $N"
fi
