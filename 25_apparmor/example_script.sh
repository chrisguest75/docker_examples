#!/usr/bin/env bash
 
mkdir -p data
echo "This is an apparmor example." 
 
touch data/sample.txt 
echo "File created" 
 
ls -l data

rm data/sample.txt 
echo "File deleted"


