#!/bin/bash

while true; do
	read line
	echo "$line" > 5_pipe
	if [[ "$line" == "QUIT" ]]; then
		echo "Exits"
		exit 0
	fi
	if [[ "$line" != [0-9]* && "$line" != "+" && "$line" != "*" ]]; then
		echo "error: wrong input data"
		exit 1
	fi
done
