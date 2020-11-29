#!/bin/bash

d=$(date +%F_%T)
mkdir ~/test 2>/dev/null && {
	echo "catalog test was created succesfully" > ~/report
	touch ~/test/"$d"
}
ping www.net_nikogo.ru 2>/dev/null || {
	d2=$(date +%F_%T)
	echo "$d2: error " >> ~/report
}
