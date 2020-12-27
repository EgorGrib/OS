#!/bin/bash
array=()
count=0
> report.log
while true
do
	array+=( 1 2 3 4 5 6 7 8 9 10 )
	let count++
	if [[ $count == 100000 ]]
	then
		count=0
		echo "${#array[@]}" >> report.log
	fi
done
