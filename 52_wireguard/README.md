# README
Demonstrate how to get wireguard setup to access a private docker network

## Server
```sh
# build and run server
docker build -f ./server/Dockerfile.server -t wireguard-server ./server  
docker run -it wireguard-server /bin/bash           

ip addr
cat /etc/wireguard/privatekey 
cat /etc/wireguard/publickey 
nano /etc/wireguard/wg0.conf 
```

## Client
```sh
# build and run client
docker build -f ./client/Dockerfile.client -t wireguard-client ./client/  
docker run -it wireguard-client /bin/bash   

ip addr
cat /etc/wireguard/privatekey 
cat /etc/wireguard/publickey 
nano /etc/wireguard/wg0.conf 
```







## Docker Compose App
```sh
docker compose up -d --build

# quick test
docker logs $(docker ps --filter name=wireguard_wgserver_1 -q)
docker logs $(docker ps --filter name=wireguard_wgclient_1 -q) 
```

### Cleanup
```sh
# bring it down and delete the volume
docker compose down --volumes
```

### Rebuild backend and run
```sh
# if changes are made to backend rerun
docker compose up -d --build
```




# Resources 
https://www.cyberciti.biz/faq/ubuntu-20-04-set-up-wireguard-vpn-server/

https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/


https://github.com/wsargent/docker-cheat-sheet/blob/master/README.md


https://www.thomas-krenn.com/en/wiki/Ubuntu_Desktop_as_WireGuard_VPN_client_configuration