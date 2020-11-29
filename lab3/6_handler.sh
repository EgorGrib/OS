#!/bin/bash

echo $$ > pid
var=1
operation=""

sigterm() {
	echo "Exits"
	exit 0
}

usr1() {
	operation="+"
}

usr2() {
	operation="*"
}

trap 'sigterm' SIGTERM
trap 'usr1' USR1
trap 'usr2' USR2

while true; do
	case "$operation" in
		"+")
			var=$((var+2))
		;;
		"*")
			var=$((var*2))
		;;
	esac
	echo "$var"
	sleep 1
done
