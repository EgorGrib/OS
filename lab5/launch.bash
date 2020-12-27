#!/bin/bash
rm data1
./mem.bash & pid=$!
echo "TIME    MEM VIRT   RES SHR CPU FREE SWAP" >> data1
while true
do
	info=$(top -b -n 1 | grep "$pid")
	info=$(echo -e $info | head -8 | awk '{print ""$11" "$10" "$5" "$6" "$7" "$9""}')
	mem=$(top -bn 1 | grep "MiB Mem" | awk '{print $8}')
	swap=$(top -bn 1 | grep "MiB Swap" | awk '{print $7}')
	echo "$info $mem $swap" >> data1
	sleep 1
done
