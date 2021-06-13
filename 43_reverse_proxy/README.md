# README
Demonstrate a simple reverse proxy to manage build deployments

TODO: 
* Build podinfo compose file

## Start
```sh
# start 
docker compose up -d
```

```sh
curl 0.0.0.0:9001          
curl 0.0.0.0:9002          
curl 0.0.0.0:8080
```

## Resources
* [podinfo](https://github.com/stefanprodan/podinfo)  
