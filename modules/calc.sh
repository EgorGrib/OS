#!/bin/bash

if [[ "$#" -ne 3 ]]
then exit 1
else if ! [[ $2 =~ ^[-]|[+]?[0-9]+$ ]] || ! [[ $3 =~ ^[-]|[+]?[0-9]+$ ]]
then exit 2
fi
case $1 in
	sum)
	let result=$2+$3 	
	echo $result
	exit 0
	;;
	sub)
	let result=$2-$3
	echo $result
	exit 0
	;;
	mul)
	let result=$2*$3
	echo $result
	exit 0
	;;
	div)
	([[ $3 -eq 0 ]] && exit 3 || echo $(($2/$3)))
	;;
	*)
	exit 2
	;;
esac
fi
