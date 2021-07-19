# README
Demonstrate how signals work in containers

## Bash

### Docker Stop (SIGTERM)
```sh
# build the bash container
docker build -t signal_bash -f ./bash/Dockerfile ./bash

# execute the container
docker run -d --name signal_bash signal_bash

# look at the logs (should see .'s)
docker logs $(docker ps --filter name=signal_bash -q)

# stop the container 
docker stop $(docker ps --filter name=signal_bash -q)

# now should see the term handler
docker logs $(docker ps -a --filter name=signal_bash -q)      

# inspect the exit code (should be 128+15=143)
docker inspect -f '{{.State.ExitCode}}' $(docker ps -a --filter name=signal_bash -q) 

# cleanup
docker rm $(docker ps -a --filter name=signal_bash -q) 
```

### Docker Kill (SIGINT)
```sh
# build the bash container
docker build -t signal_bash -f ./bash/Dockerfile ./bash

# execute the container
docker run -d --name signal_bash signal_bash

# look at the logs (should see .'s)
docker logs $(docker ps --filter name=signal_bash -q)

# send signal to the container
docker kill --signal SIGINT $(docker ps --filter name=signal_bash -q)

# now should see the term handler
docker logs $(docker ps -a --filter name=signal_bash -q)      

# inspect the exit code (should be 128+2=130)
docker inspect -f '{{.State.ExitCode}}' $(docker ps -a --filter name=signal_bash -q) 

# cleanup
docker rm $(docker ps -a --filter name=signal_bash -q) 

```

# Resources
* gracefully-stopping-docker-containers blog [here](https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers/)