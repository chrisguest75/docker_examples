# README

TODO:

* HEALTHCHECK inside container
* custom healthcheck 
* docker compose

## 🏠 Start

```sh
# start 
docker compose --env-file ./compose.env -f docker-compose.yaml up -d --force-recreate
```

## 🧪 Testing

```sh
curl -i http://0.0.0.0:8080/

curl -i http://0.0.0.0:8080/info  

watch -n 3 curl -s -i http://0.0.0.0:8080/healthz   
```

## 🔍 Troubleshooting

```sh
docker compose logs nginx   

docker compose exec -it nginx /bin/bash   
```

## 🧼 Clean up

```sh
docker compose --env-file ./compose.env -f docker-compose.yaml down      
```

## Resources

* making nginx return HTTP errors randomly [here](https://adamo.wordpress.com/2021/04/21/making-nginx-return-http-errors-randomly/)

https://github.com/openresty/lua-nginx-module

https://openresty.com/en/

https://hub.docker.com/r/openresty/openresty

https://github.com/openresty/docker-openresty

https://www.innoq.com/en/blog/nginx-ssi-env/

https://blog.sixeyed.com/docker-healthchecks-why-not-to-use-curl-or-iwr/

https://scoutapm.com/blog/how-to-use-docker-healthcheck

https://stackoverflow.com/questions/59062517/docker-compose-healthcheck-does-not-work-in-a-way-it-is-expected-for-making-cont