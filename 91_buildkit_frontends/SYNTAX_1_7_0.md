# DOCKERFILE 1.7.0

Dockerfile syntax `1.7.0` and `1.7-labs` examples.  

NOTES:

* Variable Expansions
* Parent Directories
* Exclusions
* It seems Parent Directories and Exclusions never made it into the latest frontend builds (only in -labs).  

## Test

```sh
# download a file with a checksum
just start 1_7_0
# check it exists
just dive 1_7_0
```

## Resources

* Get started with the latest updates for Dockerfile syntax (v1.7.0) [here](https://www.docker.com/blog/new-dockerfile-capabilities-v1-7-0/)
* Dockerfile release notes [here](https://docs.docker.com/build/buildkit/dockerfile-release-notes/)
