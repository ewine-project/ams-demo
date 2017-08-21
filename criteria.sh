#!/bin/bash

# takes individuals file as an input and outputs the last front (space separated criteria) 

./AMS-DEMO -individuals:${1:-"individuals.txt"} -analysis:front -gen:0,-1 -out:criteria
