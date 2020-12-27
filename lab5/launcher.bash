#!/bin/bash
for (( i=0; i<$1; i++ ))
do
	./newmem.bash $2 &
	sleep 1
done
