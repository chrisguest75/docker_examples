# TINI

Demonstrate `tini` init-system in Docker to handle SIGTERM and SIGHALT correctly.  

Docker has an inbuilt docker-init that is based on tini.  This can be activated using the --init flag.  
You can also achieve the same behaviour by handling the signals in the PID1 application.  

TODO:

* Test with ContainerD.
* Test with fargate
* Test on linux for zombie processes.

## Contents

- [TINI](#tini)
  - [Contents](#contents)
  - [Reason](#reason)
  - [Test with simple Bash](#test-with-simple-bash)
  - [Testing bash with handlers](#testing-bash-with-handlers)
  - [Test with Python](#test-with-python)
  - [Test custom tini](#test-custom-tini)
  - [Test with Node](#test-with-node)
  - [Resources](#resources)

## Reason

Doing a quick test of killing a docker container running a simple bash script takes 10 seconds without handling SIGTERM/SIGKILL.  
Using `tini` it will exit immediately.  This matters when building containers that run on auto-scaling systems such as ECS or EKS.  

## Test with simple Bash

Build the bash based container.  

```sh
# build bash example
docker build -f ./bash/Dockerfile.bash -t bashtinitest ./bash
```

Test with no `--init` flag  

```sh
# show it running (ctrl+c) to exit (no init, no tty)
# in terminal 1 
docker run --rm -i --name bashtinitest bashtinitest

# in terminal 2 ()
docker exec -it bashtinitest /bin/bash 
# see bash is pid 1
ps -ax 
# exit 
exit

# take note of time to quit docker. >10secs 
docker stop bashtinitest
```

Test with `--init` flag.  

```sh
# in terminal 1 (no tty)
docker run --init --rm -i --name bashtinitest bashtinitest  

# in terminal 2 ()
docker exec -it bashtinitest /bin/bash 
# see /sbin/docker-init is pid 1
ps -ax 
# exit and also ctrl+c in terminal 1
exit

# take note of time to quit docker. ~1sec 
docker stop bashtinitest
```

## Testing bash with handlers

If caught in the sleep subprocess it will take longer - otherwise still quicker than without `tini`  

```sh
docker build -f ./bash/Dockerfile.handlers -t bashtinitest ./bash  

# show it running (ctrl+c) to exit (no init, no tty)
# in terminal 1 
docker run --rm -i --name bashtinitest bashtinitest

# in terminal 2 ()
docker exec -it bashtinitest /bin/bash 
# see bash is pid 1
ps -ax 
# exit 
exit

# take note of time to quit docker. <4secs
docker stop bashtinitest
```

## Test with Python

Build the python based container.  

```sh
# build python example
docker build -f ./python/Dockerfile.python -t pytinitest ./python
```

Test with no `--init` flag  

```sh
# show it running (ctrl+c) to exit (no init, no tty)
# in terminal 1 
docker run --rm -i --name pytinitest pytinitest

# in terminal 2 ()
docker exec -it pytinitest /bin/bash 
# see bash is pid 1
ps -ax 
# exit 
exit

# take note of time to quit docker. >10secs 
docker stop pytinitest
```

Test with `--init` flag.  

```sh
# in terminal 1 (no tty)
docker run --init --rm -i --name pytinitest pytinitest  

# in terminal 2 ()
docker exec -it pytinitest /bin/bash 
# see /sbin/docker-init is pid 1
ps -ax 
# exit and also ctrl+c in terminal 1
exit

# take note of time to quit docker. ~1sec 
docker stop pytinitest
```

## Test custom tini

Build the custom `tini` based container.  

```sh
# build custom tini example
docker build -f ./customtini/Dockerfile.tini -t customtinitest ./customtini
```

Test with no `--init` flag  

```sh
# show it running (ctrl+c) to exit (no init, no tty)
# in terminal 1 
docker run --rm -i --name customtinitest customtinitest

# in terminal 2 ()
docker exec -it customtinitest /bin/bash 
# see bash is pid 1
ps -ax 
# exit 
exit

# take note of time to quit docker. >10secs 
docker stop customtinitest
```

Test with `--init` flag.  

```sh
# in terminal 1 (no tty)
docker run --init --rm -i --name customtinitest customtinitest  

# in terminal 2 ()
docker exec -it customtinitest /bin/bash 
# see /sbin/docker-init is pid 1
ps -ax 
# exit and also ctrl+c in terminal 1
exit

# take note of time to quit docker. ~1sec 
docker stop customtinitest
```

## Test with Node

Build the node based container.  

```sh
pushd ./node

# correct version of node
nvm use
# install modules
npm install
# build image
npm run docker:build

# using the node handlers correctly handles SIGTERM & SIGHALT, etc.
docker run -p 8000:8000 --rm -i --name nodetini nodetini         

# in terminal 2 (should respond)
curl http://0.0.0.0:8000

# take note of time to quit docker. ~1sec 
docker stop nodetini
```

## Resources

* What is advantage of Tini? [here](https://github.com/krallin/tini/issues/)  
* How To Use Tini Init system in Docker Containers [here](https://computingforgeeks.com/use-tini-init-system-in-docker-containers/)  
* krallin/tini repo [here](https://github.com/krallin/tini)
* Zombie Processes: How To Hunt, Kill and Remove a Zombie Process on Linux [here](https://www.alibabacloud.com/blog/zombie-processes-how-to-hunt-kill-and-remove-a-zombie-process-on-linux_597383)
* Unix / Linux: How to Create Zombie Process [here](https://stackpointer.io/unix/unix-linux-create-zombie-process/625/)
* Task definition parameters initProcessEnabled [here](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html)
* Support initProcessEnabled on ECS Fargate [here](https://github.com/cloudposse/terraform-aws-ecs-container-definition/issues/143)
* Best practices for building containers [here](https://cloud.google.com/architecture/best-practices-for-building-containers)  
