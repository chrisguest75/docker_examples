# README.md
Demonstrate an out of memory issue

Build the container and execute with the constraints
```
docker build -t oom .   
```

In one tab show the docker events
```
docker events
```

In another tab show the stats
``` 
docker stats
```

Execute the container and see it exit with 137
```
docker run -it --rm --memory=400m --name oom oom 
```


Events should show something like this.
```
2019-10-10T22:57:33.882123400+01:00 container die 9fce35c576814e8c520f1bb632aa1425d2eaf3cee603a9a12fe5a8cd71628d7c (exitCode=137, image=oom, name=oom)
```

You can try to blow the memory of the container whilst in the shell but it doesn't seem to get OOM killed. 
```
docker run -it --rm --entrypoint /bin/bash --name oom oom       
```