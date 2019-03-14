#!/bin/bash


## See http://mugurel.sumanariu.ro/linux/the-difference-among-virt-res-and-shr-in-top-output/ for diffeence between memory metrics
if [ "${#@}" -eq 0 ]
	then
	printf "Usage:\ntop_watch [pid] [interval(s)]  > fo \nDescription:\nGenerates table of stats from top commend for pid at specified interval\n"
	exit 0
else
	pid=$1
	d=$2
fi

## Check pid exists
top -b -p $pid -n1 | grep $pid > /dev/null
if [ $? -ne 0 ]
	then
	echo "No such PID"
	exit 1
fi

## Write the header 
top -b -n1 -p $pid | grep -E "PID[[:space:]]+USER[[:space:]]+PR[[:space:]]+NI[[:space:]]+VIRT[[:space:]]+RES[[:space:]]+SHR[[:space:]]+S[[:space:]]+%CPU[[:space:]]+%MEM[[:space:]]+TIME" | \
 	sed -E 's/[[:space:]]+/\t/g'   | cut -f6-12 
while [ $? -eq 0 ]
	do
	top -b -p $pid -n1 | awk -v x=$pid '{ if ( $1 == x ) {print $0} }' | sed -E 's/[[:space:]]+/\t/g' |  cut -f6-12
	sleep $d
	top -b -p $pid -n1 | grep $pid > /dev/null 
done
