#!/bin/bash

NAMES=("Althaf" "Zuveriya" "Umar Khalid" "Tasleem Munni")

echo "1st name is ... ${NAMES[0]}" # 1st name is ... Althaf
echo "2nd name is ... ${NAMES[1]}" # nd name is ... Zuveriya
echo "3rd name is ... ${NAMES[2]}" # 3rd name is ... Umar Khalid
echo "4th name is ... ${NAMES[3]}" # 4th name is ... Tasleem Munni

# @ it will print all movies together 

echo "All movies are: ${NAMES[@]}" #All movies are: Althaf Zuveriya Umar Khalid Tasleem Munni
