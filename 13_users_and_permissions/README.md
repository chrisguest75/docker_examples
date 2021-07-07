# Example 13 - Users and Permissions
Demonstrates how users work within a container. 

Refer to [../05_root_user/README.md](../05_root_user/README.md) for more examples.  

## Script to follow

```sh
docker build -t usertest .
docker run --rm -it --entrypoint /bin/bash usertest
```

```sh
./test_permissions.sh 
```