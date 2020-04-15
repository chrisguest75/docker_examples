# README.md
A technique to use in CI systems where it is not possible to parameterise the workflow/pipeline.  

Copied from my [14_ci_env_overrides](https://github.com/chrisguest75/shell_examples/tree/master/14_ci_env_overrides) example. 

It uses a technique where you pipe your environment through it and it will return a modified set of environment exports to be set.  

## Build 
It is a simple one script container. 

```sh
docker build -t process-env . 
```

## Run 

```sh
# Copy environment into a file to be passed into container.  
. ./ci_env
tmp_env=$(mktemp)
env > ${tmp_env}
docker run -e BRANCH=master -e COMMIT_SHA1= --env-file ${tmp_env} process-env
```