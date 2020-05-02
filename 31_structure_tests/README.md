# README
Demonstrates how to use container structure testing.

[Docs](https://github.com/GoogleContainerTools/container-structure-test)

## Prereqs
Install the container-structure-test tool 
```sh
brew install container-structure-test       
```

## TODO 
1. .env 
1. apt cache removals.
1. logs 
1. apk versions
1. globbing

## Examples
Build the container to be tested
```sh
docker build -t structure1604 -f 1604.Dockerfile .
```

Run the tests
```sh
container-structure-test test --image structure1604 --config structure_1604.yaml
```

Run the container to confirm it runs
```sh
docker run -it --rm structure1604
```

## Development of rules 
Shell into the container and look around
```sh
docker run -it --rm --entrypoint /bin/bash structure1604
```

Use container diff to analyse if files should be there or not
```sh
docker save structure1604:latest > structure1604.tar 
docker save ubuntu:16.04 > ubuntu1604.tar

container-diff diff -t file structure1604.tar ubuntu1604.tar
```


