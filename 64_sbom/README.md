# README

Demonstrates SBOM generation for docker images.  

ℹ️ NOTE: `docker sbom` is an experimental feature.  

Refer to [trivy example](../48_trivy/README.md) for installation.  

Demonstrates:

* Detection of custom debian package
* Detection of custom go binaries
* Detection of nodejs packages

📝 TODO:

* How do I upload to dependency check through API. http://192.168.x.x:8081/api/swagger.json

## SBOM Example

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

## Custom Package Scanning (docker sbom)

Docker SBOM will detect custom packages.  
Builds a custom deb package and finds it in SBOM Ref:[09_deb_pkg](https://github.com/chrisguest75/shell_examples/tree/master/09_deb_pkg)  

```sh
# build debian package in baae stage 
docker build --no-cache --progress=plain -f Dockerfile.custompkg --target builder -t $(basename $(pwd))_custompkg .

# install debian package
docker build --progress=plain -f Dockerfile.custompkg --target production -t $(basename $(pwd))_custompkg .

# check contents
docker sbom --format cyclonedx-json $(basename $(pwd))_custompkg > ./out/docker/$(basename $(pwd))_custompkg.json

# simple output from sbom showing SBOM detects go exes as well as custom packages
docker sbom $(basename $(pwd))_custompkg | grep "hello-world\|helm"
```

## NodeJs Package Scanning (docker sbom)

```sh
pushd ./ts_sbom_test
nvm use
npm install

# run targets
npm run start:dev
npm run test
npm run lint

# docker build
npm run docker:build
npm run docker:run

# create the sbom (cyclonedx)
docker sbom --format cyclonedx-json ts_sbom_test > ./out/docker/ts_sbom_test.json

# simple sbom
docker sbom ts_sbom_test
```

## Using Dependency Track

Dependency Track docs are [here](https://docs.dependencytrack.org/)

ℹ️ NOTES:

* It requires a lot of memory
* It takes a while to download the datasets at the start
* Default username:password is admin:admin

```sh
# create the envfile
LOCALIP=$(ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep --color=never 192.168)
cat <<- EOF > ./compose.env
API_BASE_URL=http://${LOCALIP}:8081
EOF

# bring up the dependency check service
docker-compose --env-file ./compose.env up -d  

# login
open http://${LOCALIP}:8080/

# show logs (if required)
docker-compose logs dtrack-apiserver   
```

## 👀 Resources

* Trivy cyclonedx [here](https://aquasecurity.github.io/trivy/v0.24.2/advanced/sbom/cyclonedx/)
* Announcing Docker SBOM: A step towards more visibility into Docker images [here](https://www.docker.com/blog/announcing-docker-sbom-a-step-towards-more-visibility-into-docker-images/)
* CycloneDX v1.4 JSON Reference [here](https://cyclonedx.org/docs/1.4/json/)
* Generate the SBOM for Docker images [here](https://docs.docker.com/engine/sbom/)  
* Docker Error - debconf: (Can't locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) [here](https://linuxamination.blogspot.com/2021/05/docker-error-debconf-cant-locate.html)
* Continuous SBOM Analysis Platform [here](https://dependencytrack.org/)  
* DependencyTrack/dependency-track repo [here](https://github.com/DependencyTrack/dependency-track)

