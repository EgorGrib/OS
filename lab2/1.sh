#!/bin/bash
ps -axu | awk '$1 == "user"' | wc -l > 1.txt
ps -axu | awk '$1 == "user" {print $2":"$11}' >> 1.txt
