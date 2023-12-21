# ECS COMPOSE

Demonstrate how to use ECS Compose  

* 59_composev2 [README.md](../59_composev2/README.md)  

## Setup

```sh
docker context create ecs myecscontext
docker context list
docker context use myecscontext

aws --profile myprofile --region eu-west-1 ecs list-clusters
```

```sh
# NOTE: This does not work.  It will not deploy to eu-west-1
export AWS_REGION=eu-west-1 
export AWS_PROFILE=my-profiles
docker compose --build --force-recreate

# NOTE: This does not work
docker compose --context myecscontext ps 

docker compose up    

```



## Resources

* Deploying Docker containers on ECS [here](https://docs.docker.com/cloud/ecs-integration/)  
