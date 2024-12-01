# README

Demonstrates how to use container structure testing.  

* [Container-Structure-Tests](https://github.com/GoogleContainerTools/container-structure-test)  Docs  
* diffoci: diff for Docker and OCI container images [here](https://github.com/reproducible-containers/diffoci)
* Deprecated [Container-diff](https://github.com/GoogleContainerTools/container-diff) in favour of `diffoci`  

TODO:

* Recursive .env file check
* apk & apt cache removals.
* Log removal
* Why is container-diff not returning differences for two containers?

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [📋 Prerequisites](#-prerequisites)
  - [🏠 Build](#-build)
  - [📋 Development of rules](#-development-of-rules)
  - [🧼 Cleanup the images](#-cleanup-the-images)
  - [Resources](#resources)

## 📋 Prerequisites

Install the `container-structure-test` tool. We also use `diffoci` to see the differences in the outputs of the containers.  

```sh
brew install container-structure-test  
brew install diffoci
brew install container-diff
```

## 🏠 Build

Build the container to be tested

```sh
docker build --no-cache -t structure1604 -f 1604.Dockerfile .
```

Run the tests and see the root user check fails.

```sh
container-structure-test test --image structure1604 --config structure_1604.yaml
```

Run the container to confirm it runs.  It uses curl to pull back [www.google.com](www.google.com).  

```sh
docker run -it --rm structure1604
```

## 📋 Development of rules

We can shell into the container and look around.  

```sh
docker run -it --rm --entrypoint /bin/bash structure1604
```

We can use `diffoci` to analyse files that have been added to the base.  

```sh
diffoci diff docker://structure1604:latest docker://ubuntu:16.04
```

Deprecated `container-diff`  

```sh
# Save the base image as tar
docker save ubuntu:16.04 > ubuntu1604.tar

# Save the image as tar
docker save structure1604:latest > structure1604.tar 

# Compare them
container-diff diff -t file structure1604.tar ubuntu1604.tar
```

## 🧼 Cleanup the images

Cleanup the images and check differences.  

```sh
# Build the cleaner iumage
docker build --no-cache -t cleanerstructure1604 -f 1604_cleaner.Dockerfile .

# Retest the container
container-structure-test test --image cleanerstructure1604 --config structure_1604.yaml

diffoci diff --semantic docker://structure1604:latest docker://cleanerstructure1604:latest
diffoci diff --semantic docker://cleanerstructure1604:latest docker://ubuntu:16.04
```

Old way with `container-diff`.  

```sh
# Save the image as tar
docker save cleanerstructure1604:latest > cleanerstructure1604.tar 

# Diff against original
container-diff diff -t file structure1604.tar cleanerstructure1604.tar
container-diff diff -t file cleanerstructure1604.tar ubuntu1604.tar
```

## Resources

* [Container-Structure-Tests](https://github.com/GoogleContainerTools/container-structure-test)  Docs  
* diffoci: diff for Docker and OCI container images [here](https://github.com/reproducible-containers/diffoci)
* Deprecated [Container-diff](https://github.com/GoogleContainerTools/container-diff) in favour of `diffoci`  
