# README.md
Demonstrate a container that can be used to generate a complete report on an image.  

All in one image Using:
* DinD [README.md](../46_dind/README.md)  
* Dockle [README.md](../22_dockle/README.md)  
* DiveCI [README.md](../30_dive/README.md)  
* Trivy [README.md](../48_trivy/README.md) 
* Grype [README.md](../49_grype/README.md) 
* Labels extraction - docker inspect
* Structure tests
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  
* Policy Verification

## Examples

```sh
mkdir -p ./analysis
mkdir -p .cache
docker build -t analysis .
docker run -d --rm --privileged -v $(pwd)/analysis:/scratch/analysis --name analysis analysis
docker exec -it analysis /bin/bash            
```

## Analyse
```sh
IMAGE=nginx:1.21.1
docker pull $IMAGE
dockle --format json $IMAGE > ./analysis/nginx_1_21_1_dockle.json
dive $IMAGE --ci --json ./analysis/nginx_1_21_1_dive.json
docker inspect $IMAGE > ./analysis/nginx_1_21_1_inspect.json
# run trivy inside the container as a container
docker run -v $(pwd)/analysis:/opt -v $(pwd)/.cache:/root/.cache --rm aquasec/trivy -f json -o /opt/nginx_1_21_1_trivy.json  $IMAGE


```


# Resources
