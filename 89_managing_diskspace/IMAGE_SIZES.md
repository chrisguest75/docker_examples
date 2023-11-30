# IMAGE SIZES

Looking at an investigating image sizes.  

ORAS examples [81_oras/README.md](../81_oras/README.md)  

TODO:

* Listing docker.io/nginx:1.23.1 is not working
* Check [80_crane/README.md](../80_crane/README.md)

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

