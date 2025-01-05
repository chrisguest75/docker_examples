# 📝 TODO

1. pipewire??
1. cgroups and namespaces
1. Start a cgroup manually using an unpacked container.
1. Can I use a cgroup command inside a container?
1. quay.io and special labels  
1. botb - break out the box image https://github.com/brompwnie/botb
1. Show how multistage builds work for testing
1. Demo using cache-from.....  Use a timed layer.
1. Use different CAPS_SYS parameters.
1. Build a apt-mirror https://www.tecmint.com/setup-local-repositories-in-ubuntu/
1. Speed of different file system layers.  i.e. If we have a 1000 layers how fast is it to find a file?
1. Diffing using different tools https://docs.docker.com/engine/reference/commandline/diff/
1. Kaniko. Caching, speed?  
2. Docker container escape with docker copy.
https://www.andreafortuna.org/2019/11/26/cve-2019-14271-a-docker-cp-container-escape-vulnerability/
1. Add procdump to the sidecar
2. mounting volumes and permissions.
3. Build a busybox image.  https://github.com/ukanth/afwall/wiki/HOWTO-Compiling-busybox
4. Show patching a container to fix an issue reported by GCR
5. Cache invalidation - package managers
6. Ordering of layers
7. Showing the process tree for docker (linux is easier)
8. Cron in a container. https://www.airplane.dev/blog/docker-cron-jobs-how-to-run-cron-inside-containers  
9. Docker users.
10. Binding to different networks localhost vs 127.0.0.1 or 0.0.0.0
11. docker plugins.
12. docker manifests
13. docker image history and using it to rebuild a container
14. https://adamo.wordpress.com/2022/05/05/removing-all-containers-via-ssh/ ssh remote_user@remote_host "docker ps -a -q|xargs -n 1 docker rm -f "
15. https://github.com/google/gvisor
16. https://github.com/tonistiigi/binfmt - docker desktop supports it
17. https://github.com/jwilder/dockerize
18. https://github.com/tonistiigi/xx
19. https://pythonspeed.com/articles/podman-buildkit/
20. https://github.com/reproducible-containers/repro-sources-list.sh