#!/bin/bash

if [[ $# -eq 2 ]]
then 
	if [[ -d "$1" ]]
	then grep -r "$2" "$1" 2> /dev/null 
	else exit 4
	fi
else exit 1
fi
exit  0
