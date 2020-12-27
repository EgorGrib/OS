#!/bin/bash
rm data
./mem.bash & pid=$!
echo "TIME    MEM VIRT   RES SHR CPU FREE SWAP" >> data
while true
do
	info=$(top -b -n 1 | grep "$pid")
	info=$(echo -e $info | head -8 | awk '{print ""$11" "$10" "$5" "$6" "$7" "$9""}')
	free=$(top -b -n 1 | head -4 | tail -n +4 | awk '{print ""$8""}')
	swap=$(top -b -n 1 | head -5 | tail -n +5 | awk '{print ""$7""}')
	echo "$info $free $swap" >> data
	sleep 1
done
