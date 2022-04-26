# README

Demonstrates SBOM generation for docker images.  

NOTE: `docker sbom` is an experimental feature.  

Refer to [trivy example](../48_trivy/README.md) for installation.  

TODO:

* Find free searchable DB for CycloneDX SBOMs
* Build a custom deb package and find it in SBOM [here](https://github.com/chrisguest75/shell_examples/tree/master/09_deb_pkg)

## Examples

```sh
# simple output from sbom
docker sbom alpine:3.15
```

## CycloneDX

Trivy output  

```sh
mkdir -p ./out/trivy
# generate sbom
trivy image --format cyclonedx --output ./out/trivy/alpine3_15.json alpine:3.15
```

Docker SBOM  

```sh
mkdir -p ./out/docker
# generate sbom
docker sbom --format cyclonedx-json alpine:3.15 > ./out/docker/alpine3_15.json
# prettify it
cat ./out/trivy/alpine3_15.json | jq . > ./out/trivy/alpine3_15_pretty.json
```

## Custom Dockerfiles

```sh
docker build --no-cache --progress=plain -f Dockerfile.ubuntu -t $(basename $(pwd)) .

docker sbom $(basename $(pwd))

# check contents
docker sbom --format cyclonedx-json $(basename $(pwd)) > ./out/docker/$(basename $(pwd)).json
```

## Resources

* Trivy cyclonedx [here](https://aquasecurity.github.io/trivy/v0.24.2/advanced/sbom/cyclonedx/)
* Announcing Docker SBOM: A step towards more visibility into Docker images [here](https://www.docker.com/blog/announcing-docker-sbom-a-step-towards-more-visibility-into-docker-images/)
* CycloneDX v1.4 JSON Reference [here](https://cyclonedx.org/docs/1.4/json/)
* Generate the SBOM for Docker images [here](https://docs.docker.com/engine/sbom/)  
