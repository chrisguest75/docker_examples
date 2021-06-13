# README
Demonstrate a simple reverse proxy to manage build deployments

TODO: 
* Build podinfo compose file
* TLS on nginx from letsencrypt

## Start
```sh
# start 
docker compose up -d


docker exec -it $(docker ps --filter name=43_reverse_proxy_nginx_1 -q) /bin/sh             
```



```sh
curl 0.0.0.0:9001          
curl 0.0.0.0:9002          
curl 0.0.0.0:8080
```

```sh
docker compose up -d
```

## Resources
* [podinfo](https://github.com/stefanprodan/podinfo)  
