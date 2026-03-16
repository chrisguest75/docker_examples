# FILESYSTEM PERMISSIONS

Work with filepermissions.  

REF: [05_root_user/README.md](../05_root_user/README.md)  
REF: [13_users_and_permissions/README.md](../13_users_and_permissions/README.md)  
REF: [chrisguest75/sysadmin_examples/10_file_permissions/README.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/10_file_permissions/README.md)

## Contents

- [FILESYSTEM PERMISSIONS](#filesystem-permissions)
  - [Contents](#contents)
  - [Test](#test)
  - [Volume](#volume)
  - [Resources](#resources)

TODO:

* Installing and copying as root then accessing as normal user
* Copying files to bindmounts and how it impacts owners etc
* New volumes as a non root user seem to prevent writing.

NOTES:

* Docker recommends using the `--mount` syntax instead of `-v`
* When docker creates a file or folder inside a container for mounts it creates them with root ownership. You can use `--chown user:group`  

## Test

Test readable and writeable file mounts.  Also test different types of file permissions for file created in the docker build.  

```sh
# start with bindmounts
just start bindmount

# CONTAINER TERMINAL
ll -l

whoami
id

./testuser.sh 
./testroot.sh 

ls /mnt/readonly/

echo "test" > /mnt/readonly/test.txt
echo "test" > /mnt/writable/test.txt

ls -l /mnt/readonly
ls -l /mnt/writable

/bin/copy.sh

ls -l /mnt/writable/
```

## Volume

Create and attach volumes to containers.  

```sh
# start with volume
just start_volume 

# CONTAINER TERMINAL
whoami

# permissions don't work
echo "test" > /mnt/readonly_volume/test.txt
echo "test" > /mnt/writable_volume/test.txt

ls -l /mnt
ls -l /mnt/readonly_volume
ls -l /mnt/writable_volume
```

Cleanup the volumes.  

```sh
just clean_volume 
```

## Resources

* Sharing local files with containers [here](https://docs.docker.com/get-started/docker-concepts/running-containers/sharing-local-files)
* Docker Volumes [here](https://docs.docker.com/engine/storage/volumes/)
* Really good breakdown of meaning of permissions [here](https://mason.gmu.edu/~montecin/UNIXpermiss.htm)  
