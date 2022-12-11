# README

```sh
export DOCKER_CONTENT_TRUST=1
# works   
docker pull ubuntu:20.04    

# fails
docker pull chrisguest/results2slack     



export DOCKER_CONTENT_TRUST=0
# works
docker pull chrisguest/results2slack     



docker trust inspect ubuntu:18.04       
```

## Resources

https://dlorenc.medium.com/notary-v2-and-cosign-b816658f044d

