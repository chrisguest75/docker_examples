# README
Demonstrate seccomp and how to use it.

# TODO:
* it does not seem to work with nginx non-privileged user

## Start
```sh
docker info 
```

## Prereqs
```sh
https://brew.sh/

brew install docker-slim
```

## Build 
```sh
# build the container
docker build --no-cache -f Dockerfile --label "org.opencontainers.image.created=$(date '+%Y-%m-%dT%H:%M:%SZ')" --label "org.opencontainers.image.version=${githubsha}" --label "org.opencontainers.image.url=$(git remote get-url origin)" -t nginx-slim-test .

# run the nginx test
docker run -it -d -p 8080:80 --name nginxtest nginx-slim-test
docker logs nginxtest 

# open the page
open http://localhost:8080/
curl http://localhost:8080/

# cleanup
docker stop nginxtest && docker rm nginxtest
```

## Slim Build
```sh
# it generates a .slim file.  
docker-slim build --include-path /usr/share/nginx/html --expose 80 --http-probe-cmd / nginx-slim-test

docker images

# run slim version
docker run -it -d -p 8080:80 --name nginxtestslim nginx-slim-test.slim
docker logs nginxtestslim 

open http://localhost:8080/
curl http://localhost:8080/


# cleanup
docker stop nginxtestslim && docker rm nginxtestslim
```

The sizes of the images are really small 
```text
nginx-slim-test.slim                                        latest    5316742d27f4   10 seconds ago   8.39MB
<none>                                                      <none>    f54a0b4a1176   4 minutes ago    133MB
nginx-slim-test                                             latest    3c59643b064d   4 minutes ago    133MB
```


## Seccomp & Apparmor
When using docker-slim look out for the artifacts location in the logs.  This is where the profiles are output. 
```text
# macosx
cmd=build info=results artifacts.location='/tmp/docker-slim-state/.docker-slim-state/images/2bb0595da47eabff14db8c0fd4d52ef51126cbee0ab06de8bdbe089970c41098/artifacts' 

# linux
cmd=build info=results artifacts.location='/home/linuxbrew/.linuxbrew/Cellar/docker-slim/1.37.0/bin/.docker-slim-state/images/510932e3104e73bd2ec0b927567b175045d473a6322d24806569a4359da53961/artifacts' 
```

Run just a profile on its own
```sh
docker-slim profile nginx-slim-test
```

```sh
# Running non-slim with profiles
docker run -it -d -p 8080:80 --security-opt seccomp:./nginx-slim-test-seccomp.json --name nginxtestslim nginx-slim-test.slim

docker logs nginxtestslim 

open http://localhost:8080/

# cleanup
docker stop nginxtestslim && docker rm nginxtestslim
```


```sh
# Running slim with profiles
docker run -it -d -p 8080:80 --security-opt seccomp:./nginx-slim-test-seccomp.json --name nginxtest nginx-slim-test

docker logs nginxtest

open http://localhost:8080/

# cleanup
docker stop nginxtest && docker rm nginxtest
```



# Resources 
* Docker seccomp docs [here](https://docs.docker.com/engine/security/seccomp/)  
https://martinheinz.dev/blog/41

https://dockersl.im/
https://github.com/docker-slim/examples
https://github.com/docker-slim/docker-slim

https://github.com/docker-slim/examples/blob/master/3rdparty/ubuntu-com/slim.sh