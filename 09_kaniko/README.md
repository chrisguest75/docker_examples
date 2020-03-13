# Script to follow
Docker in docker 

TODO:
1. How do I get the image onto my local machine registry?

Kaniko
```
docker run -v $(pwd):/workspace -it gcr.io/kaniko-project/executor:latest --context dir:///workspace/ --no-push --build-arg sleeptime=10 
```

Kaniko Debug
```
docker run -v $(pwd):/workspace -it --entrypoint=/busybox/sh gcr.io/kaniko-project/executor:debug
cd /workspace
/kaniko/executor --context dir://workspace/ --no-push --build-arg sleeptime=10 
```
