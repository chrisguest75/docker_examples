# Workflow Feature Flags
A technique to use in CI systems where it is not possible to parameterise the workflow/pipeline.  

Copied from my [14_ci_env_overrides](https://github.com/chrisguest75/shell_examples/tree/master/14_ci_env_overrides) example. 

It uses a technique where you pipe your environment through it and it will return a modified set of environment exports to be set.  

## How it works
Imagine you have a (CircleCI) workflow where you want to be able to switch on and off debug logging on integration tests or terraform.  Normally you would make a commit to the code base and retrigger.  But this changes the initial conditions, it takes time and if the tests are failing on master it may damage your commit history.  

There are usually mechanisms to set environment variables that are independent of the commit history.  

Therefore, if we have some variables that control logic in the build.  We can expose flags such as SKIP_TESTS, DEBUG_TEST_LOGS or TF_LOG and then prepend them with the branch or commitid we wish them to take effect on.  

```sh
export master_FORCE_TEST_FAIL=true
export chris_branch_SKIP_TESTS=true
export chris_branch_DEBUG_TEST_LOGS=true
export chris_branch_TF_LOG=DEBUG
export fb93e86f557c95d86e5dfc84973661183be8c5fa_SKIP_TESTS=false
```

These are then processed by the script to create a set of overrides. 

For a build executing on master branch we export.
```sh
export FORCE_TEST_FAIL=true
```

Or if we only want to SKIP_TESTS on commitid fb93e86f557c95d86e5dfc84973661183be8c5fa
```sh
export SKIP_TESTS=false
```

## Build 
It is a simple one script container. 

```sh
docker build -t workflow-flags . 
```

## Run 
To execute we snapshot the environment.  Pass it in as a file and output a new set of exports to be dot sourced.  The dot sourcing overrides the values for that particular commit or branch.   

```sh
# Setup the fake ci environment variables
. ./ci_env
```

In the workflow we would use it like this. 
```sh
# Copy environment into a file to be passed into container.  
tmp_env=$(mktemp)
env > ${tmp_env}
docker run -e BRANCH=master -e COMMIT_SHA1= --env-file ${tmp_env} workflow-flags
```

It will echo out.  Which can be written out to a file and dot sourced back over your environment. 
```sh
# BRANCH is set to master
# COMMIT_SHA1 is set to 

# FROM master_FORCE_TEST_FAIL=true
export FORCE_TEST_FAIL=true
```

## Piping 
We can simplify the process by piping the env 
```sh 
docker run -i -e BRANCH=master -e COMMIT_SHA1= workflow-flags --stdin <  <(env) 
```

## Oneliner
For a complete one liner 
```sh
export master_FORCE_TEST_FAIL=true  
. <(docker run -i -e BRANCH=master -e COMMIT_SHA1= workflow-flags --stdin <  <(env))
env
```

## Tests
[README.md](./README.md)
