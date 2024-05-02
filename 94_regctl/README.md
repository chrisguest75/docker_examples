# REGCTL

regctl is a CLI interface to the regclient library. In addition to the features listed for regclient, regctl adds the following abilities:

* Formatting output with templates.
* Push and pull arbitrary artifacts.

Related [81_oras](../81_oras/README.md)  

TODO:

* Push a helm chart in registry https://collabnix.com/how-to-build-push-helm-chart-to-docker-hub-flawlessly/
* Different content types
* How does the referrers API do?
* Get it working with AWS ECR.  

## Install

```sh
mkdir -p ./bins

# list releases
gh release list -R regclient/regclient   

# download regbot
gh release download v0.6.0 -R regclient/regclient -p regbot-darwin-amd64 --output ./bins/regbot-darwin-amd64
chmod +x ./bins/regbot-darwin-amd64

# download regctl
gh release download v0.6.0 -R regclient/regclient -p regctl-darwin-amd64 --output ./bins/regctl-darwin-amd64
chmod +x ./bins/regctl-darwin-amd64

alias regbot=$(pwd)/bins/regbot-darwin-amd64
alias regctl=$(pwd)/bins/regctl-darwin-amd64
```

## Querying registries

```sh
# doesn't work against dockerhub
regctl repo ls docker.io/chrisguest

# list the tags for nginx
regctl tag ls docker.io/nginx
regctl tag ls docker.io/chrisguest/ocitest
regctl tag ls registry.k8s.io/autoscaling/cluster-autoscaler

# lists the layers 
regctl image manifest docker.io/nginx:latest --platform linux/amd64
```

## Artifacts

The [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/README.md) is also designed generically enough to be leveraged as a distribution mechanism for any type of content. The format of uploaded manifests, for example, need not necessarily adhere to the OCI Image Format Specification so long as it references the blobs which comprise a given artifact.

```sh
# login
regctl registry login registry-1.docker.io

# list does not work
regctl artifact list registry-1.docker.io/chrisguest/demo:0.0.1
# show the API requests
regctl artifact list registry-1.docker.io/chrisguest/demo:0.0.1 -v debug

# put a file (with tag)
regctl artifact put registry-1.docker.io/chrisguest/demo:0.0.1 --file ./README.md

# put a file (with latest)
regctl artifact put registry-1.docker.io/chrisguest/demo --file ./README.md --artifact-type application/vnd.oci.readme.md

# tree only seems to list latest
regctl artifact tree registry-1.docker.io/chrisguest/demo

# get the file
regctl artifact get registry-1.docker.io/chrisguest/demo --output ./out 

# show artifact metadata
regctl image manifest registry-1.docker.io/chrisguest/demo

```

## ECR

```sh
# NOTE: THis is not working
AWS_PROFILE=myprofile aws ecr get-login-password | regctl registry login --pass-stdin --user AWS  xxxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com

regctl registry config

regctl repo ls xxxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com
```

## Resources

* regctl Documentation [here](https://github.com/regclient/regclient/blob/main/docs/regctl.md)  
* Announcing Docker Hub OCI Artifacts Support [here](https://www.docker.com/blog/announcing-docker-hub-oci-artifacts-support/)  
* Open Container Initiative Distribution Specification [here](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#api)  
* OCI Artifacts Explained [here](https://dlorenc.medium.com/oci-artifacts-explained-8f4a77945c13)  
* Artifact Authors Guidance [here](https://github.com/opencontainers/artifacts/blob/main/artifact-authors.md)  
