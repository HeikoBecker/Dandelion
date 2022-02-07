#!/bin/bash

LBR=$'\n'
#CSV file has a header TIMES="Certificate, HOL 1, HOL 2, HOL 3, Res 1, Binary 1, Res 2, Binary 2, Res 3, Binary 3, AVG HOL, AVG Binary"
CURRLINE=""

if [ "$CMLDIR" = "" ];
then
    cd cakeml || exit
    export CMLDIR="$(pwd)"
    cd ..
fi
echo "$CMLDIR"

if [ "$FLOVERDIR" = "" ];
then
    cd FloVer || exit
    export FLOVERDIR="$(pwd)"
    cd ..
fi
echo "$FLOVERDIR"

#define some functions:
function runHOL4 () {

  # For each Holmake run, we clean, then compile and measure running time
  Holmake -j1 -q clean

  #First timing measure
  RES1="$( { /usr/bin/time -f "%e" -a Holmake -j1 "$1"; } 2>"/tmp/time_$1.txt")"
  RES1="$?" #Exit code needed for Holmake runs
  TIME1="$(tail -n1 /tmp/"time_$1.txt")"

  if [ ! "$RES1" -eq 0 ];
  then return 1
  fi

  # clean
  Holmake -j1 -q clean

  #Second timing measure
  RES2="$( { /usr/bin/time -f "%e" -a Holmake -j1 "$1"; } 2>"/tmp/time_$1.txt")"
  RES2="$?"
  TIME2="$(tail -n1 /tmp/"time_$1.txt")"

  if [ ! "$RES2" -eq 0 ];
  then return 1
  fi

  # clean
  Holmake -j1 -q clean

  #Third timing measure
  RES3="$( { /usr/bin/time -f "%e" -a Holmake -j1 "$1"; } 2>"/tmp/time_$1.txt")"
  RES3="$?"
  TIME3="$(tail -n1 /tmp/"time_$1.txt")"

  CURRLINE="$CURRLINE $TIME1, $TIME2, $TIME3"
  return $RES3
}

function runBinary () {

  RES1="$( { /usr/bin/time -f "%e" -a ../../binary/sturmChecker "$1"; } 2>"/tmp/time_$1.txt")"
  TIME1=$(</tmp/"time_$1.txt")
  RES2="$( { /usr/bin/time -f "%e" -a ../../binary/sturmChecker "$1"; } 2>"/tmp/time_$1.txt")"
  TIME2=$(</tmp/"time_$1.txt")
  RES3="$( { /usr/bin/time -f "%e" -a ../../binary/sturmChecker "$1"; } 2>"/tmp/time_$1.txt")"
  TIME3=$(</tmp/"time_$1.txt")

  CURRLINE="$CURRLINE, $RES1, $TIME1, $RES2, $TIME2, $RES3, $TIME3"

}

# First compile the binary
cd binary || exit
Holmake sturmChecker
#cc sturmChecker.S "$CMLDIR"/basis/basis_ffi.o -o sturmChecker
cd ../ || exit

# Main timing experiment
cd testcases/timing || exit
for f in ./*Script.sml;
do
  # Some variables that are handy for measuring times
  FNAME="${f/Script.sml/}"
  FNAME="${FNAME/.\//}"
  THYNAME="${FNAME}Theory"
  TXTNAME="${FNAME}.txt"
  #Drop cert_ from table result
  CURRLINE="${FNAME/cert_/}, "

  #get the error from the certificate
  ERR="$(ack "eps :=" "$f" | sed 's/eps :=//' | sed 's/;//')"
  IFS='/ ' read -r -a ERRS <<< "$ERR"
  ERR1="$(echo "${ERRS[0]}" | tr -d "(" | tr -d ")")"
  ERR2="$(echo "${ERRS[1]}" | tr -d "(" | tr -d ")")"
  SCHEMESTR="(define err (exact->inexact (/ $ERR1 $ERR2)))$LBR (display err)"
  echo "$SCHEMESTR" > /tmp/"$FNAME"_err.scm
  SCHEMERES="$(mit-scheme < /tmp/"$FNAME"_err.scm | ack "display err")"
  IFS=")" read -r -a ARR <<<"$SCHEMERES"
  CERTERR="${ARR[1]}"
  #echo "$CERTERR"
  CURRLINE="$CURRLINE $CERTERR,"

  #get the infnorm from the certificate
  INFERR="$(ack "infnorm =" "$f" | sed 's/infnorm =//' | tr -d "(*" | tr -d "*)")"
  IFS='/ ' read -r -a INFERRS <<< "$INFERR"
  INFERR1="$(echo "${INFERRS[0]}" | tr -d "(" | tr -d ")")"
  INFERR2="$(echo "${INFERRS[1]}" | tr -d "(" | tr -d ")")"
  SCHEMESTR="(define err (exact->inexact (/ ${INFERR1} ${INFERR2})))$LBR (display err)"
  echo "$SCHEMESTR" > /tmp/"$FNAME"_inferr.scm
  SCHEMERES="$(mit-scheme < /tmp/"$FNAME"_inferr.scm | ack "display err")"
  IFS=")" read -r -a ARR <<<"$SCHEMERES"
  INFERR="${ARR[1]}"
  #echo "$INFERR"
  CURRLINE="$CURRLINE $INFERR,"

  if runHOL4 "$THYNAME";
  then runBinary "$TXTNAME"
  else CURRLINE="$CURRLINE 0, 0, 0, ERR, 0, ERR, 0, ERR, 0"
  fi

  # Print current result to stdout
  echo "$CURRLINE"

  #Add avg space to CSV, formula should be added in Google sheet
  CURRLINE="$CURRLINE,,"

  TIMES="$TIMES$CURRLINE$LBR"
done

#Write to log
echo "$TIMES" > log.csv
