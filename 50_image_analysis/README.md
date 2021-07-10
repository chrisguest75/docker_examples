# README.md
Demonstrate a container that can be used to generate a complete report on an image.  

All in one image Using:
* DinD [README.md](../46_dind/README.md)  
* Dockle [README.md](../22_dockle/README.md)  
* DiveCI [README.md](../30_dive/README.md)  
* Trivy
* Grype
* Labels extraction
* Structure tests
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  
* Policy Verification

## Examples

```sh
docker build -t analysis .
docker run -d --rm --privileged --name analysis analysis
docker exec -it analysis /bin/bash            
```

## Analyse
```sh
IMAGE=nginx:1.21.1
docker pull $IMAGE
mkdir -p ./analysis
dockle --format json $IMAGE > ./analysis/nginx_1_21_1_dockle.json
dive $IMAGE --ci --json ./analysis/nginx_1_21_1_dive.json
docker inspect $IMAGE > ./analysis/nginx_1_21_1_inspect.json
```


# Resources
