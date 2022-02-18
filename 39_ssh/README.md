# README

Demonstrate how to use `ssh` inside a docker container  

Creates a container running `sshd` that allows access to the nginx container on the same network.  

NOTE: This is root only login  

## Run example

```sh
# create keys
cd ./server
mkdir -p ./keys
ssh-keygen -o -a 100 -t ed25519 -f ./keys/id_ed25519 
ssh-keygen -o -a 100 -t rsa -f ./keys/id_rsa 
```

```sh
# start server
docker compose up -d 

# quick test
docker logs $(docker ps --filter name=39_ssh-internalnginx-1 -q)
docker logs $(docker ps --filter name=39_ssh-sshserver-1 -q)

# ssh onto server 
ssh -vvvv -i ./server/keys/id_rsa -p 2822 root@0.0.0.0
# curl against the nginx container
curl 172.16.238.64:80
```

## Cleanup

```sh
# bring it down and delete the volume
docker compose down 
```

### Rebuild backend and run

```sh
# if changes are made to backend rerun
docker compose up -d --build
```

## Debugging and troubleshooting

```sh
# create image
docker build -f Dockerfile.server -t sshserver .
# run 
docker run --name sshserver --rm -it -p 2822:22 sshserver

# run and open shell
docker run --name sshserver --rm -it -p 2822:22 --entrypoint /bin/bash sshserver

# start ssh
rsyslogd
service ssh start
nano /etc/ssh/sshd_config  
service ssh restart

passwd
cat /root/.ssh/authorized_keys
cat /var/log/auth.log

#PasswordAuthentication yes
#PermitEmptyPasswords yes
#PermitRootLogin without-password

# open connections (only rsa seems to work)
ssh -vvvv -i ./keys/id_ed25519 -p 2822 root@0.0.0.0
ssh -vvvv -i ./keys/id_rsa -p 2822 root@0.0.0.0
```

## Resources

* marcelloromani/dockerfiles [repo](https://github.com/marcelloromani/dockerfiles/tree/main/ubuntu-ssh-server)
* What causes SSH error: kex_exchange_identification: Connection closed by remote host? [here](https://serverfault.com/questions/1015547/what-causes-ssh-error-kex-exchange-identification-connection-closed-by-remote)
* Enable ed25519 SSH Keys Auth on Ubuntu 18.04 [here](https://rubysash.com/operating-system/linux/enable-ed25519-ssh-keys-auth-on-ubuntu-18-04/)
