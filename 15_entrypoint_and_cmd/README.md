# README

Demonstrate `ENTRYPOINT` and `CMD` operators.  

ℹ️ Notes:

* `ENTRYPOINT` controls the default program to pass your the arguments to.  
* `CMD` is an actual default command that is run when using `docker run`  

CMD documentation [here](https://docs.docker.com/engine/reference/builder/#cmd)  

The CMD instruction has three forms:

* CMD ["executable","param1","param2"] (exec form, this is the preferred form)  
* CMD ["param1","param2"] (as default parameters to ENTRYPOINT)  
* CMD command param1 param2 (shell form)  

## 🏠 Demo

### `ENTRYPOINT`

We can set the default program to be /bin/sh

```sh
docker build --target=sh -t entrypointtest_sh .

docker run --rm -it entrypointtest_sh

> ps
> echo $SHELL             
```

We can set the default program to be /bin/bash

```sh
docker build --target=bash -t entrypointtest_bash .

docker run --rm -it entrypointtest_bash             

> ps
> echo $SHELL             
```

### `CMD`

We can set the default program to be /bin/sh

```sh
docker build --target=bash_cmd -t entrypointtest_bashcmd .

docker run --rm -it entrypointtest_bashcmd                       
```
  
We can set the default program to be /bin/bash

```sh
docker build --target=bash_cmd -t entrypointtest_bashcmd .

docker run --rm -it entrypointtest_bashcmd                       
```
