#!/bin/bash
ps -ax | awk '$5 ~ "/sbin/*" {print $1}' > 2.txt
