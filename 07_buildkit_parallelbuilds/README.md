# 07 - Buildkit

Demonstrate buildkit parallel building

NOTE: This probably needs rewriting as buildkit is default now and we're not going back.  

## 📋 Script to follow

Demonstrate docker buildkit parallel builds.  

```sh
unset DOCKER_BUILDKIT
docker build --build-arg sleeptime1=10 --build-arg sleeptime2=15 -t build_kit .
```

Show that layer caching works in multistage.

```sh
docker build --build-arg sleeptime1=11 --build-arg sleeptime2=15 -t build_kit .
```

Demonstrate ordering and parallel build

```sh
# enable buildkit
export DOCKER_BUILDKIT=1 
docker build --build-arg sleeptime1=10 --build-arg sleeptime2=15 -t build_kit .
docker run -it docker_terraform version
```

Example log of parallel builds  

```log
[+] Building 18.2s (11/11) FINISHED                                                                                                                                                            
 => [internal] load .dockerignore  
 => => transferring context: 2B    
 => [internal] load build definition from Dockerfile                                                                                                               => => transferring dockerfile: 377B                                                                                                                               => [internal] load metadata for docker.io/library/bash:5.0.7                                                                                                      => [bash2 1/3] FROM docker.io/library/bash:5.0.7                                                                                                                  => => resolve docker.io/library/bash:5.0.7                                                                                                                        => [bash1 2/3] RUN echo 10                                                                                                                                        => [bash2 2/3] RUN echo 15                                                                                                                                        => [bash1 3/3] RUN sleep 10                                                                                                                                       => [bash2 3/3] RUN sleep 15                                                                                                                                       => [final 1/2] COPY --from=bash1 /usr/local/bin/bash /usr/bin/bash1                                                                                               => [final 2/2] COPY --from=bash2 /usr/local/bin/bash /usr/bin/bash2                                                                                               => exporting to image                                                                                                                                             => => exporting layers                                                                                                                                            => => writing image sha256:730c1d0ec95a3a9c8fba299a2b53622a3942017c1cfef99dd4e92873800d1a32                                                                       => => naming to docker.io/library/build_kit  
 ```
