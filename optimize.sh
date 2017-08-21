#!/bin/bash
NP=3
./make_dirs $NP
mpirun.mpich2 -np $NP -f hosts ./AMS-DEMO > optimize.log 2> optimize.err
rm -rf process*
