#!/bin/bash

git clone https://gitlab.mpi-sws.org/AVA/FloVer FloVer
cd FloVer/hol4/
Holmake
cd ..
export FLOVERDIR="$(pwd)"
cd ..

cd testcases || exit 1
export SOLLYADIR=/usr/bin
FILES=""

shopt -s nullglob
for f in ./*3Script.sml;
do
  NODOT="${f/.\//}"
  FILES="$FILES ${NODOT/Script.sml/Theory}"
done

for f in ./*4Script.sml;
do
  NODOT="${f/.\//}"
  FILES="$FILES ${NODOT/Script.sml/Theory}"
done

echo "$FILES"
Holmake $FILES
