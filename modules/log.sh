#!/bin/bash


if [[ -e "/var/log/anaconda/X.log" ]]
then
warn="$(cat /var/log/anaconda/X.log | awk '{if(($3 == "(WW)") && ($1 == "[")) print $0}')"
inf="$(cat /var/log/anaconda/X.log | awk '{if(($3 == "(II)") && ($1 == "[")) print $0}')"
echo -e "${warn//"(WW)"/"\e[33mWarning:\e[0m"}"
echo -e "${inf//"(II)"/"\e[1;34mInformation:\e[0m"}"
else exit 4
fi
