#!/bin/bash

./4_helper.sh &
pid1=$!
./4_helper.sh &
pid2=$!
./4_helper.sh &
pid3=$!

renice +10 -p $pid1
kill $pid3
at now + 1 minute <<< "pkill 4_helper.sh"
