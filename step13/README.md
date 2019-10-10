# Example 13 - Users ad Permissions
Demonstrates how users work within a container. 

## Script to follow

```sh
docker build -t usertest .
docker run --rm -it --entrypoint /bin/bash usertest
```

```
./test_permissions.sh 
```