#!/usr/bin/env bash

CID=$(basename "$(cat /proc/1/cpuset)")
#CID=$(cat /proc/self/cgroup | grep "cpu:/" | sed 's/\([0-9]\):cpu:\/docker\///g')

env

while true; do 
    echo "$(date) '${CID}' hello"
    sleep 10
done