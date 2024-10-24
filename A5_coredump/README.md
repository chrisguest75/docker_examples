# COREDUMP

Demonstrate how to debug a dumped process.  

TODO:

* Single step a process with symbols with gdb
* Attach to gdb as a remote debugger
* Attach with vscode

## Build

```bash
docker buildx build --load --progress=plain -f Dockerfile.processor -t processor .

docker run --rm -it processor

docker run --rm -it --entrypoint /bin/bash processor

gdb -q /bin/bash
readelf -n /usr/bin/bash
```

## Forcing Crashes

```sh
echo c > /proc/sysrq-trigger

kill -SIGKILL PID
pidof program_name
```

## Resources

- https://learn.microsoft.com/en-us/sysinternals/downloads/notmyfault
- https://blog.technodrone.cloud/2012/03/cause-linux-kernel-panic-or-windows.html
- Debug symbols https://ubuntu.com/server/docs/debug-symbol-packages
- https://ubuntu.com/server/docs/about-debuginfod
- https://sourceware.org/elfutils/Debuginfod.html