#!/bin/bash

cd /home/hbecker/Projects/AVA_Daisy/
shopt -s nullglob
for f in ./testcases/transcendentals/*;
do
  ./daisy --sollya --certificate=hol4 $f
done

cp /home/hbecker/Projects/AVA_Daisy/output/cert_* /home/hbecker/Projects/Dandelion/testcases/timing/
