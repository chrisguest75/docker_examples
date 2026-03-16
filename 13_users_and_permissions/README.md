# Users and Permissions

Demonstrates how users work within a container.  

REF: [05_root_user/README.md](../05_root_user/README.md)  
REF: [chrisguest75/sysadmin_examples/10_file_permissions/README.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/10_file_permissions/README.md)

## 🏠 Script to follow

```sh
# build imagees
docker build -t usertest .
```

## 👨‍💻 Default user  

```sh
# enter container as default user
docker run --name usertest --rm -it --entrypoint /bin/bash usertest

# show ids
id usertest

# run inside container
./test_permissions.sh 
```

## 👨‍💻 Root user  

```sh
# enter container as user root
docker run --name usertest -u root --rm -it --entrypoint /bin/bash usertest

# show ids
id root

# run inside container
./test_permissions.sh 
```
