#!/bin/bash

# searches for the first individual containing the provided pattern
# use: ./findIndividual 1.23456 ["individuals.txt"]

tput setf 2
cat ${2-"individuals.txt"} | grep -no -- $1 | awk -F':' '{printf $1 " "}'
echo ""
tput sgr0
