# README.md
Demonstrate layer caching behaviour with non-deterministic commands.
We pull the time from a time service to demonstrate the non-determinism. This would be akin to any command requiring an updated file. 

## Build Container
Build the container without caching.  The output of the build will show a build with a time pulled from an echo service.  
```
docker build -f makecurl.Dockerfile --no-cache -t 16_cache_fails . 
...

abbreviation: GMT
client_ip: 213.205.194.90
datetime: 2020-01-14T09:20:50.034710+00:00
day_of_week: 2
day_of_year: 14
dst: false
dst_from: 
dst_offset: 0
dst_until: 
raw_offset: 0
timezone: Europe/London
unixtime: 1578993650
utc_datetime: 2020-01-14T09:20:50.034710+00:00
utc_offset: +00:00
week_number: 3
...
```

Running the image should print out the time the file was pulled. 
```
docker run -it --rm 16_cache_fails

abbreviation: GMT
client_ip: 213.205.194.90
datetime: 2020-01-14T09:20:50.034710+00:00
...
```

Now build again and the image should be fully cached.  
```
docker build -f makecurl.Dockerfile -t 16_cache_fails .

Sending build context to Docker daemon   5.12kB
Step 1/7 : FROM ubuntu:latest as base
 ---> 549b9b86cb8d
Step 2/7 : RUN apt update && apt install make curl -y
 ---> Using cache
 ---> 8b1839a772da
Step 3/7 : RUN echo "Hello"
...
```

Therefore, the image is not rebuilt and we have an old file.
```
docker run -it --rm 16_cache_fails
```

## Build Reordered Apt List.
No caching will occur here as the order of the commands in the apt are different. 
This means the subsequent layers are also invalidated and everything is rebuilt.  
```
docker build -f curlmake.Dockerfile -t 16_cache_fails .
```
