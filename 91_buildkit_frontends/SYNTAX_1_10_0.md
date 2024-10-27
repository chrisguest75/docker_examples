# DOCKERFILE 1.10.0

Dockerfile syntax 1.10.0 examples.  

## Test

```sh
# validate version of buildkit (checks require >0.15)
docker buildx version             

# download a file with a checksum
just start 1_10_0
# check it exists
just dive 1_10_0
```

## Resources

* Dockerfile release notes [here](https://docs.docker.com/build/buildkit/dockerfile-release-notes/)
