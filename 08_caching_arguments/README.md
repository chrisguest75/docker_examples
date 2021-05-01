# Example 8 - Layer caching with arguments
Demonstrate layer caching and how different build arguments values will not be cached until built.  

TODO:
1. Remove specific layers from cache
        ```log
        Step 2/5 : ARG sleeptime
        ---> Using cache
        ---> 9b92fcacc779
        ```

## Script to follow
Caching behaviour with build arguments

```sh
# Before starting remove the cached image (this leaves behind intermediate layers though)
docker rmi $(basename $(pwd))
```

```sh
# will fail because the sleeptime arg is not set
docker build -t $(basename $(pwd)) .

# all of these will rebuild the sleeptime step
docker build --build-arg sleeptime=10 -t $(basename $(pwd)) .
docker build --build-arg sleeptime=11 -t $(basename $(pwd)) .
docker build --build-arg sleeptime=12 -t $(basename $(pwd)) .
```

After building first layers they should all be cached and retained. 
```sh
# Once built with the args as values it should be fully cached
docker build --build-arg sleeptime=10 -t $(basename $(pwd)) .
docker build --build-arg sleeptime=11 -t $(basename $(pwd)) .
docker build --build-arg sleeptime=12 -t $(basename $(pwd)) .
```

## Clean up   
```sh
# Remove image
docker rmi $(basename $(pwd))
```