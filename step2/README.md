# Script to follow
Shows the kernel version during build.   
When run shows the kernel version. 

```
docker build --no-cache -t scratchtest .
docker run scratchtest
```

# Examples

```
Linux 83fe3d9188f8 4.15.0-55-generic #60-Ubuntu SMP Tue Jul 2 18:22:20 UTC 2019 x86_64 Linux
Linux 3659e36111ba 4.9.184-linuxkit #1 SMP Tue Jul 2 22:58:16 UTC 2019 x86_64 Linux
```