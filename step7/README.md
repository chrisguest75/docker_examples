# Script to follow
Demonstrate docker buildkit parallel builds. 

```
unset DOCKER_BUILDKIT
docker build --build-arg sleeptime1=10 --build-arg sleeptime2=15  -t build_kit .
```

Show that layer caching works in multistage.
```
docker build --build-arg sleeptime1=11 --build-arg sleeptime2=15  -t build_kit .
```

Demonstrate ordering and parallel build
```
export DOCKER_BUILDKIT=1 
docker build --build-arg sleeptime1=10 --build-arg sleeptime2=15  -t build_kit .
docker run -it docker_terraform version
```
