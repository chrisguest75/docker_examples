# README

Demonstrate semgrep on dockerfile and other standard container resources

## 📋 Prerequisites

```sh
# install semgrep 
brew install semgrep

# show version - 0.72.0 
semgrep --version 
```

## 🔍 Scanning

Use `semgrep` to scan files.  

### 🔍 Scan dockerfile

```sh
# seems this ruleset is not up-to-date
semgrep -vvv --config "p/dockerfile" --error Dockerfile.*
# use ruleset 
semgrep -vvv --config="r/generic.dockerfile" --error Dockerfile.*
```

### 🔍 Scan Bash

```sh
semgrep -vvv --config="r/bash"
```

### 🔍 Scan nginx.conf

```sh
# build a nginx basd docker image
docker build --no-cache -f Dockerfile.nginx_root -t nginx_test .
docker run --rm -it -d -p 8080:80 --name nginx_test nginx_test
docker cp nginx_test:/etc/nginx/conf.d/default.conf .  

open http://0.0.0.0:8080

docker stop nginx_test

# 7 out of 11 rules in the ruleset
semgrep --config "p/nginx"
semgrep -vvv --config "r/generic.nginx"    


# build a nginx basd docker image
docker build --no-cache -f Dockerfile.nginx_nonroot -t nginx_test .
docker run --rm -it -d -p 8080:80 --name nginx_test nginx_test
docker cp nginx_test:/etc/nginx/conf.d/default.conf .  
   
```

### 🔍 Scan HTML

```sh
semgrep -vvv --config="r/html"
```

### Other rules

There are other rules that can be applied.  

```sh
cd ../
semgrep -vvv --config "p/github-actions"      
semgrep --config="r/generic"
```

## 👀 Resources

* Semgrep website [here](https://semgrep.dev/)  
* Semgrep rules repository [here](https://github.com/returntocorp/semgrep-rules)  
* Semgrep registry [here](https://semgrep.dev/r)  
* CLI usage [here](https://semgrep.dev/docs/cli-usage/)  
