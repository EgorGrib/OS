#!/bin/bash

operation="+"
var=1

(tail -f 5_pipe) |
while true; do
	read line
	case "$line" in
		"+")
			operation="$line"
			echo "plus"
		;;
		"*")
			operation="*"
			echo "multiplication"
		;;
		[0-9]*)
			case $operation in
				"+")
					result=$(($var+$line))
					echo "$result"
				;;
				"*")
					result=$(($var*$line))
				;;
			esac
		;;
		"QUIT")
			killall tail
			exit 0
		;;
		*)
			killall tail
			exit 1
		;;
	esac
done
