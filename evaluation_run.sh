#!/bin/bash
# this script prepares input variables for coolsim, runs coolsim and converts
# its output in a two step procedure to a final result: output.txt which can
# then be read directly by the AMS-DEMO optimizer
input1="input.txt"
input2="sim_in.txt"
wr_var="./WR_VAR"
wr_obj="./WR_OBJ"
simulator="./NewCool.exe"

if [ "$1" != "" ] && ls $1 > /dev/null
then
#	echo $1 "is dir"
	input1=`echo $1"/"$input1`
	input2=`echo $1"/"$input2`

	wr_var=`echo "."$wr_var`
	wr_obj=`echo "."$wr_obj`
	simulator=`echo "."$simulator`
	cd $1
else
	echo $1 "is not dir"
fi

echo $input1 " -> " $input2
echo "# dummy file to test simulator execution length constantness" > input.txt
awk '{if (NR>1) {print $0}}' input.txt > sim_in.txt
$wr_var sim_in.txt Input/waters.dat
wine $simulator
$wr_obj Input/waters.dat Input/variable.dat Output/cost.dat sim_out.txt
awk '{if (NR==2) {print "################################# "; print "# violation ", $0} else if ((NR > 2) && (NR < 6)) {print $0}}' sim_out.txt > output.txt
