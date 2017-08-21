#!/bin/bash

#
# run solver, using optimizer generated input.txt for input
# transform solver's output to output.txt, that will be read by the optimizer
#
# arguments: [optional]subdirectory_for_execution
#

# cd to target subdir (only in subdir is provided as the first argument)
if [ -d "$1" ]; 
then
	startDir="../"
	cd $1
else
	startDir="./"
fi
# convert comment line followed by newline separated values (in imput.txt) to space separated values (in optim.opt)
tail -n +2 input.txt | tr \\n \ > optim.par
# run solver (assume where it is at)
$startDir"CavityProblem"
# convert solver results (RawData/Default.par/optim.csv) to newline separated values (output.txt.1)
cat RawData/Default.par/optim.csv | tr \; \\n > output.txt.1
# write comment and reorder output.txt (lines 3 and 5 are objectives, 6 is violation, others are informational)
echo "#created by runSolver.sh script" > output.txt
divergence=`sed -n '6p' output.txt.1`
violation=`echo | awk '{ if ('$divergence' < 0) {print "1"} else {print "0"}}'`
convergenceTime=`sed -n '4p' output.txt.1`
convergenceViolation=`echo | awk '{ if ('$convergenceTime' < 20) {print "0"} else {print "1"}}'`
#cat RawData/Default.par/optim.csv
#echo " divergence="$divergence", violation="$violation", convergenceTime="$convergenceTime", convergenceViolation="$convergenceViolation", total violation="
violation=$(( $violation+$convergenceViolation ))
echo "violation="$violation


if [ "$violation" -ge "1" ]
then
	# in case of violation, echo comment #violation violation_price
	echo | awk '{ print "#violation " '$violation' }' >> output.txt
fi

sed -n '3p' output.txt.1 >> output.txt
sed -n '5p' output.txt.1 >> output.txt
sed -n '1,2p' output.txt.1 >> output.txt
sed -n '4p' output.txt.1 >> output.txt

cd $startDir 

