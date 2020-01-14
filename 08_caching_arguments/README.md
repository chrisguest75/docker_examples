## Example 8 - Layer caching with arguments
Demonstrate layer caching.  

# Script to follow
Caching with arguments

```
docker build -t scratchtest .

docker build --build-arg sleeptime=10 -t scratchtest .
docker build --build-arg sleeptime=11 -t scratchtest .
docker build --build-arg sleeptime=12 -t scratchtest .
```

After building first layers they should all be cached and retained. 
```
docker build --build-arg sleeptime=10 -t scratchtest .
docker build --build-arg sleeptime=11 -t scratchtest .
docker build --build-arg sleeptime=12 -t scratchtest .

```