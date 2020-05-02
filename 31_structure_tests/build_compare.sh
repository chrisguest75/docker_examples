#!/usr/bin/env bash

rm *.tar

# Export the ubuntu image
echo "Export ubuntu1604.tar"
docker pull ubuntu:16.04 
docker save ubuntu:16.04 > ubuntu1604.tar

# Simple basic ubuntu upgrades 
echo "Build structure1604.tar"
docker build --no-cache -t structure1604 -f 1604.Dockerfile .
docker save structure1604:latest > structure1604.tar 

echo "Diff ubuntu1604.tar structure1604.tar"
container-diff diff --json ubuntu1604.tar structure1604.tar 
container-diff diff -t file ubuntu1604.tar structure1604.tar 

# Cleaner ubuntu upgrades 
echo "Build structurecleaner1604.tar"
docker build --no-cache -t structurecleaner1604 -f 1604_cleaner.Dockerfile .
docker save structurecleaner1604:latest > structurecleaner1604.tar 

echo "Diff structure1604.tar structurecleaner1604.tar"
container-diff diff --json structure1604.tar structurecleaner1604.tar
container-diff diff -t file structure1604.tar structurecleaner1604.tar
