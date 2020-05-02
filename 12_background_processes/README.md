## Example 12 - Background processes
Demonstrate creating background processes.  

**NOTE:** If any of the background processes die, the container still continues. Docker only monitors PID1. This is why the general advice is that you should only have 1 process per container. 

# Script to follow
Demonstrate creating background processes.
Multiple processes are created within the container.  

```
docker build -t scratchtest .
docker run -it scratchtest
```