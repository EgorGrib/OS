#!/bin/bash

for pid in $(ps -eo pid | sed 1d)
do
	file_status="/proc/"$pid"/status"
	file_sched="/proc/"$pid"/sched"
	ppid=$(grep -Ehis "ppid" "$file_status" | grep -o "[0-9]\+")
	sum_exec_runtime=$(grep -Ehis "se\.sum_exec_runtime" "$file_sched" | awk '{print $3}')
	nr_switches=$(grep -Ehis "nr_switches" "$file_sched" | awk '{print $3}')
	if [[ -z $ppid ]]
	then continue
	fi
	average_runtime=$(echo "scale=4; $sum_exec_runtime/$nr_switches" | bc)
	echo "$pid $ppid $average_runtime"
done | sort -nk2 | awk '{print "PID="$1" : PPID="$2" : ART="$3""}' > 4.txt
