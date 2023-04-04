# README

Demonstrate `docker contexts`

Docker contexts are not related to the context we pass as part of the image build.  


```sh
docker context ls 
docker context inspect default

 docker context create --help
docker context create ecs myecscontext

[
    {
        "Name": "myecscontext",
        "Metadata": {
            "Type": "ecs"
        },
        "Endpoints": {
            "docker": {
                "SkipTLSVerify": false
            },
            "ecs": {
                "Profile": "myprofile"
            }
        },
        "TLSMaterial": {},
        "Storage": {
.....
        }
    }
```

## Resources

https://docs.docker.com/engine/context/working-with-contexts/

