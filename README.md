# AMS-DEMO (Asynchronous Master-Slave Differential Evolution for Multiobjective Optimization)

## Abstract

This repository contains an implementation of AMS-DEMO algorithm for optimization of functions implemented as bash scripts.

## How to use

### Build the project

#### Build the libraries

The project makes use of three libraries that are also supplied in the include subdirectory. The build process will build libraries and put binaries into the lib subdirectory:
```bash
cd copyOfLibs
make
cd ..
```

#### Build the DEMO executable
To use the project on a single-machine, build the sequential version of the binary. No special libraries (others than those provided) are required for this version.
```bash
make clean
make DEMO
```

#### Build the AMS-DEMO executable 
To build the project for use on a cluster or another parallel/distributed system with MPI environment and development libraries installed, build AMD-DEMO. 
Note that mpic++.mpich is used to compile and link the binary. Change it to other mpi enabled compiler for any particular system you wish to compile on.
```bash
make clean
make AMS-DEMO
```

### Running optimization

An example of optimization is given in subdirectory example. Open a shell in that directory and follow the procedure below.

#### Setting up optimization

The optimization is fully set up by providing settings.ini with the required settings - both optimization and problem.related.
See settings.ini for an example and description of all the settings that are available.

#### Run parallel optimization on mpich enabled system
```bash
cd example
# provide the hostnames for worker computers in the file "hosts"
./optimize.sh
```
Note that the std out and err streams produced by AMS-DEMO are redirected to optimize.log and optimize.err files in the script.

#### Run parallel optimization - commandline

1. First create the hostsfile for the designated MPI system.
2. Create subdirectories process1, ... processNP, where NP is the number of processes to execute on. AMS-DEMO will use those directories for communication with sub-processes it spawns. Each sub-process should have its own dedicated directory since will contain input and output files they and they run in parallel; if they shared a directory then race condition would occur on files and communication would be full of errors.
3. Call AMS-DEMO with appropriate settings (number of processes, hostnames, etc):
```bash
mpirun <settings> ../AMS-DEMO
```

#### Run sequential optimization - commandline

1. Call DEMO
```bash
./AMS-DEMO
```

#### View optimization results

There are several files that contain various information related to the completed optimization.

1. evaluations.txt contains the inputs, outputs and parameters for all executed evaluations.
2. individuals.txt contains the inputs, outputs and parameters for individuals of current population (including the initial, usually random population) and is output after every n-th evaluation completes, where n is population size.
3. featureFile.txt contains info about the optimization execution - the hosts involved and the analysis of times
4. timeSeqX.txt (for X = 1..pn; pn is the number of slave processes) contains detailed timing information for each host that is used in debugging and for detailed speedup analysis.
5. front.txt contains the final front (multiobjective optimization result is the front of solutions - the set of non-dominated solutions from the set of all considered solutions).

## Research

1. When using AMS-DEMO please cite: http://www.mitpressjournals.org/doi/abs/10.1162/EVCO_a_00076
