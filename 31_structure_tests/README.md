# README
Demonstrates how to use container structure testing.

[Container-Structure-Tests](https://github.com/GoogleContainerTools/container-structure-test)  Docs   
[Contaienr-diff](https://github.com/GoogleContainerTools/container-diff)  Docs   

## Prereqs
Install the container-structure-test tool. We also use container-diff for a  
```sh
brew install container-structure-test  
brew install container-diff      
```

## TODO 
1. Checks
    1.  recursive .env file check
1. apk & Apt cache removals.
1. Log removal 
1. Why is container-diff not returning differences for two containers?

## Examples
Build the container to be tested
```sh
docker build --no-cache -t structure1604 -f 1604.Dockerfile .
```

Run the tests and see the root user check fails.
```sh
container-structure-test test --image structure1604 --config structure_1604.yaml
```

Run the container to confirm it runs.  It uses curl to pull back www.google.com
```sh
docker run -it --rm structure1604
```

## Development of rules 
We can shell into the container and look around. 
```sh
docker run -it --rm --entrypoint /bin/bash structure1604
```

We can use container-diff to analyse files that have been added to the base.  
```sh
# Save the base image as tar
docker save ubuntu:16.04 > ubuntu1604.tar
# Save the image as tar
docker save structure1604:latest > structure1604.tar 
# Compare them
container-diff diff -t file structure1604.tar ubuntu1604.tar
```

## Cleanup the images

```sh
# Build the cleaner iumage
docker build --no-cache -t cleanerstructure1604 -f 1604_cleaner.Dockerfile .
# Retest the container
container-structure-test test --image cleanerstructure1604 --config structure_1604.yaml
# Save the image as tar
docker save cleanerstructure1604:latest > cleanerstructure1604.tar 
# Diff against original
container-diff diff -t file structure1604.tar cleanerstructure1604.tar
container-diff diff -t file cleanerstructure1604.tar ubuntu1604.tar

```
