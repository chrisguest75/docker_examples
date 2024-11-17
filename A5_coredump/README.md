# COREDUMP

Demonstrate how to debug a dumped process.  

TODO:

* Single step a process with symbols with gdb
* Attach to gdb as a remote debugger
* Attach with vscode

## Build

```bash
just build

just start

just debug

gdb -q /bin/bash
readelf -n /usr/bin/bash
```

## Forcing Crashes

```sh
# readonly filesystem does not allow it
echo c > /proc/sysrq-trigger

kill -SIGKILL PID
pidof program_name
```

## Resources

- NotMyFault v4.21 (windows only) [here](https://learn.microsoft.com/en-us/sysinternals/downloads/notmyfault)
- Cause a Linux Kernel Panic or a Windows BSOD [here](https://blog.technodrone.cloud/2012/03/cause-linux-kernel-panic-or-windows.html)
- Debug symbol packages [here](https://ubuntu.com/server/docs/debug-symbol-packages)
- About debuginfod [here](https://ubuntu.com/server/docs/about-debuginfod)
- ELFUTILS DEBUGINFOD [here](https://sourceware.org/elfutils/Debuginfod.html)  
- Pleasant debugging with GDB and DDD [here](https://begriffs.com/posts/2022-07-17-debugging-gdb-ddd.html#gdb-front-ends)
- Configuring and Managing Core Dumps in Linux [here](https://www.baeldung.com/linux/managing-core-dumps)  