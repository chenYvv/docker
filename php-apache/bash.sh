#!/bin/sh
step=1
for (( i = 0; i < 60; i=(i+step) ));
do 
	echo $i
	sleep $step 
done
	exit 0