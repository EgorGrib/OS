#!/bin/bash

log=/var/log/anaconda/X.log
if [[ -e "$log" ]]
then
cat -e $log | grep "] (WW)" | sed -E "/WW/s//$(printf "\e[33mWarning\e[0m")/"; 
cat -e $log | grep "] (II)" | sed -E "/II/s//$(printf "\e[1;34mInformation\e[0m")/";
else exit 4
fi
