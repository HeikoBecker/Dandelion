#!/bin/bash

PRECISION="53"
DEGREE="5"
PRECSTR="--Sollya-Precision=$PRECISION"
DEGSTR="--Sollya-degree=$DEGREE"

cd /home/hbecker/Projects/AVA_Daisy/
shopt -s nullglob
sbt compile && sbt script

for f in ./testcases/transcendentals/*;
do
  echo $f
  echo $PRECSTR
  echo $DEGSTR
  ./daisy --sollya $PRECSTR $DEGSTR --store-infnorm --certificate=hol4 $f
done

for f in ./testcases/approx/*;
do
  echo $f
  ./daisy --sollya $PRECSTR $DEGSTR --store-infnorm --certificate=hol4 $f
done

for f in ./testcases/fpbench/*;
do
  echo $f
  ./daisy --sollya $PRECSTR $DEGSTR --store-infnorm --certificate=hol4 $f
done

for f in ./testcases/fpbench_separate/*;
do
  echo $f
  ./daisy --sollya $PRECSTR $DEGSTR --store-infnorm --certificate=hol4 $f
done

cp /home/hbecker/Projects/AVA_Daisy/output/cert_* /home/hbecker/Projects/Dandelion/testcases/timing/
