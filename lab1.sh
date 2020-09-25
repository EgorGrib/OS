#!/bin/bash

function module() {
output="$(/home/user/lab1/modules/$1.sh "$2" $3 $4 $5 $6)" 2> /dev/null
return=$?
if [[ $return -eq 0 ]]
then 
	echo "$output"
	exit 0
else case $return in 
	1) echo "Error: Wrong number of arguments">&2
	;;
	2) echo "Error: Invalid argument value">&2
	;;
	3) echo "Error: Division by zero attemp">&2
	;;
	4) echo "Error: Directory or file was not found">&2
	;;
	5) echo "Error: No access">&2
	;;
	esac
	exit $return
fi
}

function interactive() {
actions=( "calc" "log" "reverse" "search" "strlen" "help" "exit" )
while :
do
	echo -e "Choose one of the commands:\n0. calc\n1. log\n2. reverse\n3. search\n4. strlen\n5. help\n6. exit"
	echo -e "\nEnter number or name of command: "
	read command
	if [[ $command =~ ^[0-9]+$ ]]
		then if [[ $command -lt ${#actions[@]} ]] && [[ $command -ge 0 ]]
			then c=${actions[$command]}
		else echo "Error: Unknown command"
	continue
 	fi
	else 	
		if [[ ${actions[@]} =~ ("$command") ]] 
		then c="$command"
		else echo "Error: Unknown command"
		continue
		fi
	fi
	if ! [[ "log" =~ ("$c") || "help" =~ ("$c") ]] 
	then echo "Enter arguments:"
	read arg1 arg2 arg3 arg4
	fi
	case $c in
	calc|search|reverse|log|strlen)
		echo "$(module $c $arg1 $arg2 $arg3 $arg4)"
		continue
		;;
	help)
		echo $(cat /home/user/lab1/help.txt)
		;;
	"exit")
		if ! [[ -z "$arg1" ]]
	       	then exit $arg1
		else exit 0
		fi
		;;
	esac
done
}

if [[ $# -eq 0 ]]
then 
	echo $(cat /home/user/lab1/help.txt)
	exit -2
fi

case $1 in 
calc|search|reverse|strlen|log)
	if [[ $# == 1 ]] && [[ $1 != "log" ]]
		then exit -2
	fi	
	echo "$(module $1 "$2" $3 $4 $5 $6)"
	exit $?
	;;
"exit")
	[[ $# -eq 1 ]] && exit 0 || exit $2 2> /dev/null
	;;
help)
	echo $(cat /home/user/lab1/help.txt)
	exit 0
	;;
interactive)
	interactive
	exit $?
	;;
*)
	echo "Error: Unknown command">&2
	echo $(cat /home/user/lab1/help.txt)
	exit -1
	;;
esac
