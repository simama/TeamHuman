#!/bin/bash

function run_all {
    COUNTER=0
    RANGE=1000
    while [  $COUNTER -lt $RANGE ]; do
        python classifier.py --no_progress_bar --serialize 9 -s solutions/solution_$COUNTER.prm
        let COUNTER=COUNTER+1 
    done
}

rm output.tmp;
rm error.log
rm solutions/*
echo "Starting to run 1000 iterations. Numbers will posted in output.tmp"
run_all 1> output.tmp 2>error.log &

