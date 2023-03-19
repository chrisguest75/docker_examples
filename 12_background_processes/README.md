# BACKGROUND PROCESSES

Demonstrate creating background processes.  

ℹ️ NOTE: If any of the background processes die, the container still continues. Docker only monitors PID1. This is why the general advice is that you should only have 1 process per container.  

## 🏠 Script to follow

Demonstrate creating background processes.
Multiple processes are created within the container.  

```sh
# build the image
docker build -t scratchtest .
# run the image
docker run -it scratchtest
```
