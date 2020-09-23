#!/bin/bash

if [[ $# -eq 2 ]]
	then 
	if [[ -e $1 && -e $2 ]]
		then	
		if [[ -w "$2" ]]
			then 
			reversed=$(tac $1) 2> /dev/null
			echo "$reversed" | rev> $2
			exit 0		
		else exit 5
		fi
	else exit 4
	fi
else exit 1
fi	
