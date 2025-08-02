# TAILSCALE

Adding a docker container as a node in a tailnet.  

## Container

```sh
docker pull tailscale/tailscale:latest
```

## Start Device

Go to the tailscale portal and generate an install script to get the oauth key to configure in the `.env`.  
To start the container the tag needs to be added to the acesss policy.  

```json
"tagOwners": {
    "tag:container": ["myemail@provider.com"],
},
```

```sh
docker compose --env-file ./.env up
```

## Access

Goto the machines list in tailscale and find the endpoint. Machines on the tailnet can access nginx using the URL.  

## Resources

* https://tailscale.com/kb/1282/docker

