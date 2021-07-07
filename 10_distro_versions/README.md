# README
Demonstrate different ways to find distro versions inside a container

TODO:
* Bring in some different base distro images 
* Show ways to identify them and print out build and version info from inside the container

## Examples

```sh
cat /etc/os-release
uname -a
lsb_release -a 

/sys/
```