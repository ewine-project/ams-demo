#!/bin/bash

# arguments: filename linenum

# take input filename form settings.ini (last occurence of input file name property)
#inputFile=`grep "^input file name" settings.ini | tail -n 1 | awk '/ / { print $5 }'`
inputFile=`grep "^input file name" settings.ini | tail -n 1 | awk 'split($0, a, "=") { print a[2] }'`
# take commandline form settings.ini (last occurence of command line property)
commandLine=`grep "^command line" settings.ini | tail -n 1 | awk 'split($0, a, "=") { print a[2] }'`
# take number of objectives form settings.ini
numCriteria=`grep "^criteria vector length" settings.ini | tail -n 1 | awk 'split($0, a, "=") { print a[2] }'`


# extract linenum-th line from filename file
line=`tail -n +$2 $1 | head -n 1`
# extract input vector (2nd column) from line 
string=`echo $line | tr \\  \\\\n | tail -n +2 | head -n 1 | tr -d [\\<\\>]`
# make input.txt from the extracted string
echo "----- making input file: $inputFile -----"
echo "# this is reevaluate_individuals.sh created input" > $inputFile
`echo $string | tr \\, \\\\n >> $inputFile`
# evaluate!
echo "----- running evaluation: $commandLine -----"
$commandLine
# compare results (output function output - 5th column in line, if properties are set)
echo "----- saved result (first line) in comparison to reevaluation (second line) -----"
oldResult=`echo $line | tr \\  \\\\n | tail -n +5 | head -n 1 | tr -d [\\<\\>]`
echo $oldResult
newResult=`tail -n +2 output.txt | head -n $numCriteria`
echo $newResult | tr \  \,

