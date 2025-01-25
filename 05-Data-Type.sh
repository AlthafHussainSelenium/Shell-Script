#!/bin/bash

# Printing the time

TIMESTAMP=$(date)
echo "script executed at ... $TIMESTAMP"

# Addition of 2 numbers
Number1=$1
Number2=$2

SUM=$(($Number1+$Number2))

echo "Sum of two numbers is ... $SUM"

Number1=20
Number2=30

SUM=$(($Number1+$Number2))

echo "Sum of two numbers is ... $SUM"

