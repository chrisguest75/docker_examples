# FILESYSTEM PERMISSIONS

TODO:

* Installing and copying as root then accessing as normal user
* chown and chgrp
* Ensuring files are accessible to a non-root user
* Copying files to bindmounts and how it impacts owners etc
* 

NOTES:

* Docker recommends using the `--mount` syntax instead of `-v`
* When docker creates folder inside a container for mounts it creates them with root ownership.  

## Test

```sh
# start with bindmounts
just start

# CONTAINER TERMINAL
whoami

ls /mnt/readonly/

echo "test" > /mnt/readonly/test.txt
echo "test" > /mnt/writable/test.txt

ls -l /mnt/readonly
ls -l /mnt/writable

/bin/copy.sh

ls -l /mnt/writable/
```

## Volume

```sh
# create volume
docker volume create filesystempermissions_volume

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

## Resources

* https://docs.docker.com/get-started/docker-concepts/running-containers/sharing-local-files
* https://docs.docker.com/engine/storage/volumes/