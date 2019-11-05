# README.md
We can set the default program to be /bin/sh
```
docker build --target=sh -t entrypointtest_sh .
docker run --rm -it entrypointtest_sh
ps
echo $SHELL             
```

We can set the default program to be /bin/bash
```
docker build --target=bash -t entrypointtest_bash .
docker run --rm -it entrypointtest_bash             
ps
echo $SHELL             
```

We can set the default program to be /bin/sh
```
docker build --target=bash_cmd -t entrypointtest_bashcmd .
docker run --rm -it entrypointtest_bashcmd                       
```
We can set the default program to be /bin/bash
```
docker build --target=bash_cmd -t entrypointtest_bashcmd .
docker run --rm -it entrypointtest_bashcmd                       
```

