#!/bin/bash

#Set HOL4 commit variable
#HOLCOMMIT="$(cat .HOLCOMMIT)"

#HOL4 always cloned exactly here --> must be in this folder
#if [ ! -d "./HOL4" ];
#then
#    echo "HOL4 not installed, starting to install HOL4 into current directory."
#    echo "If this is not intended, please abort with Ctrl-c"
#    sleep 5
#
#    git clone https://github.com/HOL-Theorem-Prover/HOL.git HOL4
#    cd HOL4
#else
#    cd ./HOL4
#fi
#
#poly < tools/smart-configure.sml
#bin/build
#export HOLDIR="$(pwd)"
#cd ../

git clone https://gitlab.mpi-sws.org/AVA/FloVer FloVer
cd FloVer/hol4/
Holmake
cd ..
export FLOVERDIR="$(pwd)"
cd ..

git clone https://github.com/CakeML/cakeml cakeml
cd cakeml
git checkout d8dc70502a73effe17411f0d7eeaa80c1d9fab98
export CMLDIR="$(pwd)"
cd ..

Holmake

cd binary
Holmake sturmChecker

