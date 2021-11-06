# README
Demonstrate dockerslim and how to use it to reduce container sizes.

Docs are [here](https://dockersl.im/)  

# TODO:
* it does not seem to work with nginx non-privileged user.  
* Docs has some information on this. 

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



# Resources 
* Docker slim examples cmdlines [https://github.com/docker-slim/examples](https://github.com/docker-slim/examples)
* Docker slim repo [https://github.com/docker-slim/docker-slim](https://github.com/docker-slim/docker-slim)
* Example of keeping paths [https://github.com/docker-slim/examples/blob/master/3rdparty/ubuntu-com/slim.sh](https://github.com/docker-slim/examples/blob/master/3rdparty/ubuntu-com/slim.sh)