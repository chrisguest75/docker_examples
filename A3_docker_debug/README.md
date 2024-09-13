# DOCKER DEBUG

You can use docker debug with distroless containers to help diagnose issues using tools that are not installed into the container.  

REF: [26_sidecar_debugging/README.md](../26_sidecar_debugging/README.md)

TODO:

* Example using distroless/chainguard.

NOTE:

* Docker Debug requires a Pro, Teams, or Business Subcription.  
* It uses Nix as the package manager.  

```sh
docker debug <containerid>

# use privileged in the debug container
docker debug --privileged 282f31449de0
# getting environment of a process requires privilege
cat /proc/15/environ
```

## Resources

* docker debug [here](https://docs.docker.com/reference/cli/docker/debug/)
