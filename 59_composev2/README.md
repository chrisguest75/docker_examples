# README

Demonstrate how to use docker compose v2.
Other examples using Compose:

* 44_reverse_proxy [README.md](./44_reverse_proxy/README.md)  
https://github.com/chrisguest75/mongo_examples/blob/main/03_ffprobe/docker-compose.yaml
https://github.com/chrisguest75/sysadmin_examples/blob/master/07_coredns_tcpdump/docker-compose.yaml



## Build

```sh
docker compose up  

docker-compose --profile backend up -d --build

docker compose config --profiles  

# quick test
docker logs $(docker ps --filter name=03_ffprobe-mongodb-1 -q)


# bring it down and delete the volume
docker-compose --profile backend down --volumes

nginx with a heredoc config and a curl container dockerfile that gets built.  

docker logs

dedicated network.

```

## Resources

