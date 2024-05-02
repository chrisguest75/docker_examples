# DOCKERFILE 1.7.0

Dockerfile syntax 1.7.0 examples.  

NOTES:

* Variable Expansions
* Parent Directories
* Exclusions

```sh
docker buildx build --progress=plain -f Dockerfile.1_7_0 -t exclusions .
# examine output and see ARM64 and AMD64 strings coming from different architectures
docker run -it exclusions

# inspect the image
dive exclusions
```

## Resources

* Get started with the latest updates for Dockerfile syntax (v1.7.0) [here](https://www.docker.com/blog/new-dockerfile-capabilities-v1-7-0/)
