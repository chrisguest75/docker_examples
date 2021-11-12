# README
Demonstrate semgrep on dockerfile 

## Prereqs

```sh
# install semgrep 
brew install semgrep

# show version - 0.72.0 
semgrep --version 
```

## Scan dockerfile
Scan docker file
```sh
# seems this ruleset is not up-to-date
semgrep -vvv --config "p/dockerfile" --error
# use ruleset 
semgrep -vvv --config="r/generic.dockerfile" --error
```

## Scan bash
```sh
semgrep -vvv --config="r/bash"
```

## Scan nginx.conf
Scan nginx.conf
```sh
docker build --no-cache -f Dockerfile.nginx_root -t nginx_test .
docker run --rm -it -d -p 8080:80 --name nginx_test nginx_test
docker cp nginx_test:/etc/nginx/conf.d/default.conf .  

# 7 out of 11 rules in the ruleset
semgrep --config "p/nginx"
semgrep -vvv --config "r/generic.nginx"        
```

## Scan HTML
Scan html file
```sh
semgrep -vvv --config="r/html"
```

## Other rules
There are other rules that can be applied. 
```sh
cd ../
semgrep -vvv --config "p/github-actions"      
semgrep --config="r/generic"
```

# Resources 
* Semgrep website [here](https://semgrep.dev/)  
* Semgrep rules repository [here](https://github.com/returntocorp/semgrep-rules)
* CLI usage [here](https://semgrep.dev/docs/cli-usage/)  


