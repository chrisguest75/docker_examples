# IMAGE SIZES

Looking at an investigating image sizes.  

* ORAS examples [81_oras/README.md](../81_oras/README.md)  
* Dive examples [30_dive_ci/README.md](../30_dive_ci/README.md)  

TODO:

* Listing docker.io/nginx:1.23.1 is not working
* Check [80_crane/README.md](../80_crane/README.md)
* Dive is broken on WSL

## Sizes

```sh
# print out sizes
just docker-details nginx:1.27.0

# open dive
just docker-dive nginx:1.27.0
```

## Uncompressed sizes

```sh
# this will get the uncompressed sizes
docker images
```

## Compressed sizes on registry

```sh
# THIS IS NOT WORKING AGAINST DOCKER
oras manifest fetch docker.io/nginx:1.23.1 | jq '[.layers[].size] | add'
```

## Resources

* Retrieving Docker Image Sizes [gist](https://gist.github.com/MichaelSimons/fb588539dcefd9b5fdf45ba04c302db6)
