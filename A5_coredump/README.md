# COREDUMP

Demonstrate how to debug a dumped process.  

TODO:

- Single step a process with symbols with gdb
- Attach with vscode

## Glossary

- elfutils debuginfod is a client/server in elfutils 0.178+ that automatically distributes elf/dwarf/source-code from servers to clients such as debuggers across HTTP. [source](https://sourceware.org/elfutils/Debuginfod.html)

## Build

```bash
just build

just start

just debug
```

## Forcing Crashes

Inside the container.  

```sh
gdb -q /bin/bash
readelf -n /usr/bin/bash

# start sleep and dump 
sleep 500 &
gcore -o sleep [pid]  

# source is not available
gdb sleep ./sleep.11 
```

```sh
# variables associated to core
sysctl --all | grep core

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
- core - core dump file [here](https://man7.org/linux/man-pages/man5/core.5.html)
- Configuring core dumps in docker [here](https://ddanilov.me/how-to-configure-core-dump-in-docker-container)
- The Core Pattern (core_pattern), or how to specify filename and path for core dumps [here](https://sigquit.wordpress.com/2009/03/13/the-core-pattern/)

