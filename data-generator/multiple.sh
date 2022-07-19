#!/bin/bash

# Runs generate.sh multiple times in parallel to create a log file with interleaved log lines

# Usage: ./multiple.sh iterations starting-trans-number out-file
#    e.g. ./multiple.sh 10 500 test.log"

if (( "$#" != 3 )) 
then
    echo "Usage: ./multiple.sh iterations starting-trans-number out-file"
    echo "e.g. ./multiple.sh 10 500 test.log"
exit 1
fi

iterations=$1
trans=$2
outfile=$3

i="0"

while [ $i -lt $iterations ]
do
trans=$(($trans + 1))
echo "trans ${trans}"
./generate.sh $trans $outfile &
sleep 2
i=$[$i+1]
done
wait


