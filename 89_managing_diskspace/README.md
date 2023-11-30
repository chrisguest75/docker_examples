# MANAGING DISKSPACE

Give some examples and advice on how to manage disk space with docker.  

NOTE:

* This is mainly aimed at MacOS.  

## Image sizes

Goto [IMAGE_SIZES.md](IMAGE_SIZES.md) for examples of how to think about image sizes.  

## Checking allocation

```sh
docker buildx du
docker system df

# follow a link
readlink `which docker`

ls -la ~/Library/Containers/com.docker.docker/Data/vms/0/data
```

Enter the hyperkit VM and try looking at the filesystem.  

```sh
# enter the 
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh

ls -lR /var/lib/docker
```

## Cleanup

```sh
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)
docker rmi $(docker images -qa)

docker image prune --all --volumes --force
docker system prune --all --force
```

## Troubleshooting

If you're getting trouble running some of the commands to calculate disk space. Then I recommend `system pruning` all of docker and shrinking the space allocated. You can shrink the available filesystem space in the preferences.   
Once you've changed the filesize you can try again.  

```sh
# check Docker.raw filesize again.  
ls -la ~/Library/Containers/com.docker.docker/Data/vms/0/data
```

```log
docker system df

"Error response from daemon: error getting build cache usage: failed to get usage for 81gunw3gs7w0toclpwnyc3acy: error creating overlay mount to /var/lib/docker/overlay2/2fu9qq01p11oesb3tsk67a7m3/merged: invalid argument"
```

### Hyperkit

```sh
cat  ~/Library/Containers/com.docker.docker/Data/vms/0/hyperkit.json | jq .

ls -l  ~/Library/Containers/com.docker.docker/Data/log/host
```

## Resources

* How to inspect volumes size in Docker [here](https://medium.com/homullus/how-to-inspect-volumes-size-in-docker-de1068d57f6b)
* Doing a bit of Docker Cleanup [here](https://nodogmablog.bryanhogan.net/2021/11/doing-a-bit-of-docker-cleanup/)
* Reclaim disk space by removing stale and unused Docker data [here](https://medium.com/@alexeysamoshkin/reclaim-disk-space-by-removing-stale-and-unused-docker-data-a4c3bd1e4001)  
