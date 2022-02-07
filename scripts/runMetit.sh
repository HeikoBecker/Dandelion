#!/bin/bash

TPTPDIR="$HOME/Downloads/metit-dist-new/Linux-x86_64/tptp"
MATH_KERNEL="$HOME/bin/MathKernel"
Z3_NONLIN="$HOME/Downloads/metit-dist-new/Linux-x86_64/bin/z3"
export MATH_KERNEL

LBR=$'\n'
TIMES=""

for f in ./*.tptp;
do
    FNAME="${f/.\//}"
    FNAME="${FNAME/.tptp/}"
    RES1="$( { /usr/bin/time -f "%e" -o "/tmp/time_$FNAME.txt" "$HOME/Downloads/metit-dist-new/Linux-x86_64/bin/metit" --time 600.0 -m --autoIncludeExtended --tptp "$TPTPDIR" "$f"; } )"
    TIME1="$(tail -n1 /tmp/"time_$FNAME.txt")"

    RES2="$( { /usr/bin/time -f "%e" -o "/tmp/time_$FNAME.txt" "$HOME/Downloads/metit-dist-new/Linux-x86_64/bin/metit" --time 600.0 -m --autoIncludeExtended --tptp "$TPTPDIR" "$f"; } )"
    TIME2="$(tail -n1 /tmp/"time_$FNAME.txt")"

    RES3="$( { /usr/bin/time -f "%e" -o "/tmp/time_$FNAME.txt" "$HOME/Downloads/metit-dist-new/Linux-x86_64/bin/metit" --time 600.0 -m --autoIncludeExtended --tptp "$TPTPDIR" "$f"; } )"
    TIME3="$(tail -n1 /tmp/"time_$FNAME.txt")"

    if [ "$(echo "$RES1" | ack "Theorem" | wc -l)" -eq 0 ];
    then
        if [ "$(echo "$RES1" | ack "GaveUp" | wc -l)" -eq 0 ];
        then
            echo "Failure for $f$:"
            TIMES="$TIMES$FNAME, Failure, $TIME1, $TIME2, $TIME3"
        else
            TIMES="$TIMES$FNAME, GaveUp, $TIME1, $TIME2, $TIME3"
        fi
    else
        TIMES="$TIMES$FNAME, Theorem, $TIME1, $TIME2, $TIME3"
    fi

    TIMES="$TIMES$LBR"

    echo "$TIMES" > log_metit.csv
done
