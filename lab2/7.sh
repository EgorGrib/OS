#!/bin/bash

touch temp
ps -axu | awk '{print $2" "$11}' | tail -n +2 | sort -nk1 | head -n -5 > temp
while read line
do
	file_id=$(awk '{print $1}' <<< $line)
	file_bytes=$(grep "read_bytes" /proc/"$file_id"/io | awk '{print $2}')
	file_path=$(awk '{print $2}' <<< $line)
	echo $file_id" "$file_path" "$file_bytes >> temp1
done < temp
sleep 1m

cat temp |
while read line
do
	pid=$(awk '{print $1}' <<< $line)
	mem2=$(grep "read_bytes" /proc/"$pid"/io | awk '{print $2}')
	path=$(awk -v id="$pid" '{if($1 == id) print $2}' < temp1)
	mem1=$(awk -v id="$pid" '{if($1 == id) print $3}' < temp1)
	mem=$(echo "$mem2 - $mem1" | bc)
	echo $pid":"$path":"$mem
done | sort -t ":" -nk3 | tail -n 3
rm temp
rm temp1
