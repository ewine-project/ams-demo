#!/bin/bash

# find fronts for all generations
mkdir animation
./AMS-DEMO -individuals:${1-"individuals.txt"} -analysis:front -gen:1,-1 -out:criteria > FrontAnim.txt

# grab plot constraints
generations=`sort FrontAnim.txt -n -k1 | tail -n 1  | awk '{print $1}'`
xmax=`sort FrontAnim.txt -n -k2 | tail -n 1  | awk '{print $2}'`
ymax=`sort FrontAnim.txt -n -k3 | tail -n 1  | awk '{print $3}'`

#for generation in {1..$generations..1}
for (( generation=1; generation<=$generations; ++generation))
do
	# filter generation
	cat FrontAnim.txt | grep "^$generation " > FrontAnimGen.txt
	zpGen=`printf "%05d" $generation`
	printf "\rProcessing frame #%d" $generation	
	# open persistant gnuplot
gnuplot << EOF
set title "${1-"Last front"}"
set xr [0:$xmax]
set yr [0:$ymax]
set xlabel "Heat flow"
set ylabel "Coverage"
set term gif
set output "animation/$zpGen.gif"
plot "FrontAnimGen.txt" using 2:3 with points pointsize 1.4 pointtype 7 title "Generation $generation"
#pause 1
EOF
done
printf "\ncreating animation"
convert animation/*.gif -delay 30 -loop 0 temp.gif 
printf "\noptimizing animation"
convert temp.gif -layers optimize anim.gif
rm temp.gif
rm animation/*
rm FrontAnim.txt FrontAnimGen.txt
echo
echo all done, your animation has been stored as:
echo  anim.gif
echo

