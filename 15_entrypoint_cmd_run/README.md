# README

Demonstrate `ENTRYPOINT`, `CMD` and `RUN` operators.  

ℹ️ NOTES:

* `ENTRYPOINT` controls the default program to pass your the arguments to.  
* `CMD` is an actual default command that is run when using `docker run`
* `RUN` can be used in either exec or shell form. It is useful when no shell exists like in scratch and distroless containers.  

CMD documentation [here](https://docs.docker.com/engine/reference/builder/#cmd)  

The CMD instruction has three forms:

* CMD ["executable", "param1", "param2"] (exec form, this is the preferred form)  
* CMD ["param1", "param2"] (as default parameters to ENTRYPOINT)  
* CMD command param1 param2 (shell form)  

## 🏠 Demo

### `ENTRYPOINT`

We can set the default program to be /bin/sh

```sh
just entrypoint

> ps
> echo $SHELL             
```

We can set the default program to be /bin/bash

```sh
just entrypoint bash

> ps
> echo $SHELL             
```

### `CMD`

We can set the default program to be /bin/sh

```sh
just cmd sh
```
  
We can set the default program to be /bin/bash

```sh
just cmd bash                      
```

## Resources

* Docker Best Practices: Choosing Between RUN, CMD, and ENTRYPOINT [here](https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/)