# Example 13 - Users and Permissions

Demonstrates how users work within a container.  

Refer to [../05_root_user/README.md](../05_root_user/README.md) for more examples.  

## Script to follow

```sh
# build imagees
docker build -t usertest .
```

## Default user  

```sh
# enter container as default user
docker run --name usertest --rm -it --entrypoint /bin/bash usertest

# run inside container
./test_permissions.sh 
```

## Root user  

```sh
# enter container as user root
docker run --name usertest -u root --rm -it --entrypoint /bin/bash usertest

# run inside container
./test_permissions.sh 
```
