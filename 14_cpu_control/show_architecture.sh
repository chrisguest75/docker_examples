#!/usr/bin/env bash
cat /proc/version
lscpu
uname -a    

#stress -c 1 --timeout 10s
stress-ng --cpu $WORKERS --timeout $TIMEOUT --metrics 
