# DOCKER SCOUT

Docker Scout analyzes image contents and generates a detailed report of packages and vulnerabilities that it detects.  

## Contents

- [DOCKER SCOUT](#docker-scout)
  - [Contents](#contents)
  - [Alternative Scanners](#alternative-scanners)
  - [Plugin](#plugin)
  - [Scan](#scan)
  - [Resources](#resources)

## Alternative Scanners

* Grype [README.md](../49_grype/README.md)  
* Trivy [README.md](../48_trivy/README.md)  
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  

## Plugin

```sh
# get version of docker scout plugin
docker info
```

## Scan

```sh
# a wolfi images
docker scout quickview wolfi-ffmpeg-nodejs:test-amd64

# sca bookworm slim
docker pull node:18-bookworm-slim

# overview
docker scout quickview node:18-bookworm-slim

# break it down by package
docker scout cves --format only-packages --only-vuln-packages  node:18-bookworm-slim

docker scout cves --format only-packages --only-vuln-packages local://my-image
```

## Resources

* Docker Scout quickstart [here](https://docs.docker.com/scout/quickstart/)
* Software supply chain, simplified [here](https://www.docker.com/products/docker-scout/)
* Docker Scout image analysis [here](https://docs.docker.com/scout/image-analysis/)
* docker/scout-cli [repo](https://github.com/docker/scout-cli)
* Filter Out Security Vulnerability False Positives with VEX [here](https://www.docker.com/blog/filter-out-security-vulnerability-false-positives-with-vex/)
