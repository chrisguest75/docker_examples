#!/bin/sh

# If any of these processes dies the container still continues.
echo "Starting"
for i in $(seq 1 4); do 
    echo "Creating background $1"
    /bin/background $i &
done


while [[ true ]];do 
    sleep 5
    ps 
done 