# README
Demonstrate seccomp and how to use it.

TODO: 

brew install docker-slim

docker-slim build registry.heroku.com/github-of-life/web
docker-slim build --include-path /usr/share/nginx/html --expose 80 --http-probe-cmd / registry.heroku.com/github-of-life/web


it generates a .slim file.  
https://github.com/docker-slim/docker-slim


registry.heroku.com/github-of-life/web.slim                 latest    cb4dbbb50cea   7 seconds ago    8.49MB
registry.heroku.com/github-of-life/web                      latest    a8705f9fd213   10 days ago      136MB
registry.heroku.com/github-of-life/web.slim                 latest    d0535983c5ca   6 seconds ago   10.9MB

docker run --rm -it -d -p 8080:80 --name githuboflife registry.heroku.com/github-of-life/web.slim

open http://localhost:8080/

docker stop githuboflife    

## Start
```sh
docker info 
```

# Resources 
* Docker seccomp docs [here](https://docs.docker.com/engine/security/seccomp/)  
https://martinheinz.dev/blog/41

https://dockersl.im/
https://github.com/docker-slim/examples

https://github.com/docker-slim/examples/blob/master/3rdparty/ubuntu-com/slim.sh