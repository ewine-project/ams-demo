#!/bin/bash

# takes individuals file as an input and outputs the last front (all fields)
# awk removes the comments (lines starting with #)
# use: extract the last front for reevaluation

./AMS-DEMO -individuals:${1-"individuals.txt"} -analysis:front -gen:-1 | awk '{if (substr($1,1,1)!="#") print $0;}' | sort -k 3,3 -t \< 
