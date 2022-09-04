# README

Demonstrate how to use `docker compose` healthchecks.  

NOTES:

* ERROR_RATE controls recipricol 1/ERROR_RATE chance of 500 error. 

TODO:

* HEALTHCHECK inside container

## 🏠 Start

```sh
# start (use this to restart if changes are made)
docker compose --env-file ./compose.env -f docker-compose.yaml up -d --force-recreate
```

## 🧪 Testing

```sh
# openresty homepage
curl -i http://0.0.0.0:8080/

# /info is a hardcoded route in nginx config
curl -i http://0.0.0.0:8080/info  

# the healh endpoint is configured to return a 1/100 500 error
watch -n 3 curl -s -i http://0.0.0.0:8080/healthz   

SERVICENAME=nginx 
docker inspect --format='{{json .State.Health}}' $(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)") | jq .
```

## 🔍 Troubleshooting

```sh
# show nginx logs
docker compose logs nginx   

# inspect output
SERVICENAME=nginx            
docker inspect $(docker ps -aq --format '{{.Names}}' --filter "id=$(docker compose ps $SERVICENAME -q)")

# step into container to check configuation
docker compose exec -it nginx /bin/bash   
```

## 🧼 Clean up

```sh
# remove the services
docker compose --env-file ./compose.env -f docker-compose.yaml down      
```

## Resources

### OpenResty

* OpenResty [here](https://openresty.com/en/)  
* OpenResty on DockerHub [here](https://hub.docker.com/r/openresty/openresty)
* OpenResty docker repo [here](https://github.com/openresty/docker-openresty)
* making nginx return HTTP errors randomly [here](https://adamo.wordpress.com/2021/04/21/making-nginx-return-http-errors-randomly/)
* lua-nginx-module repo [here](https://github.com/openresty/lua-nginx-module)
* I was thinking NGINX was the best until i knew OPENRESTY [here](https://moneyforward.com/engineers_blog/2022/03/14/openresty/)




### Healthcheck

* Docker Healthchecks: Why Not To Use `curl` or `iwr` [here]( https://blog.sixeyed.com/docker-healthchecks-why-not-to-use-curl-or-iwr/)
* How to Use Docker’s Health Check Command [here](https://scoutapm.com/blog/how-to-use-docker-healthcheck)
* docker-compose healthcheck does not work in a way it is expected for making container a run first and then container B [here](https://stackoverflow.com/questions/59062517/docker-compose-healthcheck-does-not-work-in-a-way-it-is-expected-for-making-cont)
* How to Add a Health Check to Your Docker Container [here](https://howchoo.com/devops/how-to-add-a-health-check-to-your-docker-container#see-the-health-status)  


