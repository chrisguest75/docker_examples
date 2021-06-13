# README
Demonstrate a simple reverse proxy to manage build deployments

TODO: 
* TLS on nginx from letsencrypt

## Start
```sh
# start 
docker compose up -d
```

## Testing
```sh
# services
curl -i http://0.0.0.0:9001/a/env          
curl -i http://0.0.0.0:9002/b/env

# nginx reverse proxy
curl -i http://0.0.0.0:8080
curl -i http://0.0.0.0:8080/a/
curl -i http://0.0.0.0:8080/b/
curl -i http://0.0.0.0:8080/a/env
curl -i http://0.0.0.0:8080/b/env
```

## Debugging
```sh
# nginx
docker exec -it $(docker ps --filter name=43_reverse_proxy_nginx_1 -q) /bin/sh   

# logs from containers
docker logs $(docker ps --filter name=43_reverse_proxy_nginx_1 -q)
docker logs $(docker ps --filter name=43_reverse_proxy_info_a_1 -q)
docker logs $(docker ps --filter name=43_reverse_proxy_info_b_1 -q)

# get onto ubuntu container
docker exec -it $(docker ps --filter name=43_reverse_proxy_ubuntu_1 -q) /bin/sh   
```

# Clean up
```sh
docker compose down
```

## Resources
* [podinfo](https://github.com/stefanprodan/podinfo)  
* [compose-spec](https://github.com/compose-spec/compose-spec/blob/master/spec.md)  
* [cmdline options](https://github.com/stefanprodan/podinfo/blob/master/charts/podinfo/templates/deployment.yaml)  
* [reverse-proxy](https://phoenixnap.com/kb/docker-nginx-reverse-proxy)  
* [docker-networks](https://docs.docker.com/network/)  
* [plugins_network](https://docs.docker.com/engine/extend/plugins_network/)  