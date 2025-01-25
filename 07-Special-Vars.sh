#!/bin/bash


Number1=$1
Number2=$2

# To get Values of variables used in the script
echo "Values of variables used in the script is ... $@" 

# To get total number of variables used in the script
echo "Number of variables used in the script is ... $#"

# To print present working directory
echo "Present working directory is ... $PWD"

# To print Home directory
echo "Home directory is ... $HOME"

# To print Current user
echo "Current user is ... $USER"

# To print the process id of current running script
echo "Process of current running script is ... $$"

# To print the process of the last command in background
sleep 30 & # & used to send this process to background
echo "Process of the last command in bckground is ... $!"
