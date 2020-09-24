#!/bin/bash

function module() {
output="$(/home/user/lab1/modules/$1.sh "$2" $3 $4 $5 $6)" 2> /dev/null
return=$?
if [[ $return -eq 0 ]]
then 
	echo "$output"
	exit 0
else case $return in 
	1) echo "Error: Wrong number of arguments" >&2
	;;
	2) echo "Error: Invalid argument value" >&2
	;;
	3) echo "Error: Division by zero attemp" >&2
	;;
	4) echo "Error: Directory or file was not found" >&2
	;;
	5) echo "Error: No access" >&2
	;;
	esac
	exit $return
fi
}

function interactive() {
actions=( "${module_is_here[@]}" "help" "exit" )
while :
do
	echo "Choose one of the command:"
	i="0"
	for m in ${actions[@]}; do
		echo "$i. $m"
		i=$(($i+1))
		done	
	echo -e "\nEnter number or name of command: "
	read command
	if [[ $command =~ ^[0-9]+$ ]] 
		then
		if [[ $command -lt ${#actions[@]} ]] && [[ $command -ge 0 ]] 
		then m=${actions[$command]}
	       	else echo "Error: This command is not in the list"
		continue
 		fi
	else 	
		if [[ ${actions[@]} =~ ("$command") ]] 
		then m="$command"
		else echo "Error: Unknown command"
		continue
		fi
	fi
	if ! [[ "log" =~ ("$m") || "help" =~ ("$m") ]] 
	then echo "Enter arguments:"
	read first second third fourth
	fi
	case $m in
	calc|search|reverse|log)
		echo "$(module $m $first $second $third $fourth)"
		continue
		;;
	help)
		echo $(cat /home/user/lab1/help.txt)
		;;
	"exit")
		if ! [[ -z "$first" ]]
	       	then exit $first
			else exit 0
		fi
		;;
	esac
done
}

all_modules=("calc" "log" "reverse" "search" "strlen")
for t in ${all_modules[@]}; do
	if [[ -e "/home/user/lab1/modules/$t.sh" ]]
		then module_is_here+=( "$t" )
		else module_not_found+=( "$t" )
	fi
done

if ! [[ -z "$module_not_found" ]]
	then echo "Some modules were not founded: ${module_not_found[@]}">&2
fi

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
	if [[ ${module_is_here[@]} =~ ($1) ]]
		then	
		echo "$(module $1 "$2" $3 $4 $5 $6)"
		exit $?
	else echo "You cant run a module that wasnt found">&2
	exit -2
	fi
	;;
"exit")
	([[ $# -eq 1 ]] && exit 0 || ([[ $2 =~ ^[-]?[0-9]+$ ]] && exit $2 || echo "Error: you need enter the return code">&2; exit -1))
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
	echo "Error: Unknown command"
	echo $(cat /home/user/lab1/help.txt)
	exit -1
	;;
esac
