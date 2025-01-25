#!/bin/bash

# condition expressions
# -gt, -lt, -eq, -ne, -ge, le

# if condition
# syntax
# if [conition]; then
#     statement
# fi

# write a program to check a number is grater than 100
# NUMBER=$1
NUMBER=120
if [ $NUMBER -gt 100 ]; then
    echo "$NUMBER is grater than 100"
fi

# syntax
# if else condition
# if [condition]; then
#     Statement
# else
#     statement
# fi

# Checking if a File Exists
FILE="/DevOps/Linux/devop"
if [ -f "$FILE" ]; then
    echo "$FILE is present in the directory"
else
    echo "$FILE is present in the directory"
fi

# Comparing Two Numbers
NUMBER1=10
NUMBER2=10

if [ $NUMBER1 -gt $NUMBER2 ]; then
    echo "$NUMBER1 is grater then $NUMBER2"
elif [ $NUMBER1 -lt $NUMBER2 ]; then
    echo "$NUMBER2 is grater then $NUMBER1"
else
    echo "$NUMBER1 is equal to $NUMBER2"
fi

# Checking User Input
echo "Enter Your Name: "
read NAME
# The -z option is used in shell scripting to check if a string is empty.
# It returns true if the string is empty and false otherwise.
if [ -z "$NAME" ]; then
    echo "You did not entered the name"
else
    echo "Your name is ... $NAME"
fi
# Using a Case Statement
NUM1=10
NUM2=20
echo "Choose an operation:"
echo "1) Add"
echo "2) Subtract"
echo "3) Multiply"
OPERATION=2
echo "Your Opertaion is ... $OPERATION"

case $OPERATION in
1)
    RESULT=$(($NUM1 + $NUM2))
    echo "The sum of two number is ... $RESULT"
    ;;
2)
    RESULT=$(($NUM1 - $NUM2))
    echo "Subtraction of two numbers is ... $RESULT"
    ;;
3)
    RESULT=$(($NUM1 * $NUM2))
    echo "The multiplaction of two numbers is ... $RESULT"
    ;;
4)
    RESULT=$(($NUM1 / $NUM2))
    echo "Division of two numbers is ... $RESULT"
    ;;
esac

# Compound Conditions with AND and OR

FILE="/path/to/file"
DIR="/path/to/directory"

if [ -f "$FILE" ] && [ -r "$FILE" ]; then
    echo "File $FILE exists and is readable."
else
    echo "File $FILE does not exist or is not readable."
fi

if [ -d "$DIR" ] || [ -w "$DIR" ]; then
    echo "Directory $DIR exists or is writable."
else
    echo "Directory $DIR does not exist and is not writable."
fi
