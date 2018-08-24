#!/bin/bash

if [ -z ${PYTHIA6PATH+x} ];
then
    echo "PYTHIA6PATH is unset. exit";
    exit
else
    echo "PYTHIA6PATH is set to '$PYTHIA6PATH'";
fi

xSections=(15 30 50 80 120 170 220 280 370 460 540 630 720 800)

for i in "${xSections[@]}"
do
    echo "Checking x-sec $i (in mb)"
    grep "All included subprocesses" $PYTHIA6PATH/logs/xsec_$i.log 
done

echo "Job Complete"
