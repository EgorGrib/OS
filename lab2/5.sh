#!/bin/bash

prev_ppid="0"
count="0"
M="0"
touch "5.txt"

echo -e "$(<"4.txt")\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |
while read line
do
	pid=$(awk '{print $1}' <<< $line)
	ppid=$(awk '{print $2}' <<< $line)
	average_runtime=$(awk '{print $3}' <<< $line)
	if [[ $prev_ppid == $ppid ]]
	then 
		count=$(($count+1))
		M=$(echo "scale=4; $M+$average_runtime" | bc)
		str=$(awk '{print "PID="$1" : PPID="$2" : ART="$3}' <<< $line)
		echo $str >> "5.txt"
	else 
		M=$(echo "scale=4; $M/$count" | bc)
		echo "Average_Sleeping_Children_of_PatioentID="$prev_ppid" is "$M >> "5.txt"
		prev_ppid=$pid
		count=1
		M=$average_runtime
		tmp=$(awk '{print "PID="$1" : PPID="$2" : ART="$3}' <<< $line)
		echo $tmp >> "5.txt"
	fi
done
