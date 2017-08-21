#!/bin/bash

# point to AMS-DEMO executable
amsDemoExec=../AMS-DEMO

# number of processors used
NP=$(wc -l hosts | awk '{print $1}')

# make directories for parallel execution
./make_dirs $NP

# for mpich:
mpirun.mpich -np $NP -f hosts $amsDemoExec > optimize.log 2> optimize.err
echo mpirun.mpich -np $NP -f hosts $amsDemoExec

# for openmpi:
#mpirun.openmpi -np 2 -hostfile hosts ../AMS-DEMO > optimize.log 2> optimize.err

# clean up temporary directories and files
rm -rf process*
