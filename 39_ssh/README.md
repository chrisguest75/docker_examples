# README

Demonstrate how to use `ssh` inside a docker container  

NOTE: This is root only login  

## Debugging

```sh
# create keys
cd ./server
mkdir -p ./keys
ssh-keygen -o -a 100 -t ed25519 -f ./keys/id_ed25519 
ssh-keygen -o -a 100 -t rsa -f ./keys/id_rsa 

# create image
docker build -f Dockerfile.server -t sshserver .
# run 
docker run --name sshserver --rm -it -p 2822:22 sshserver
# run and open shell
docker run --name sshserver --rm -it -p 2822:22 --entrypoint /bin/bash sshserver

service ssh start
rsyslogd
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

## Docker Compose

```sh
docker compose up -d --build

# quick test
docker logs $(docker ps --filter name=ssh_sshserver_1 -q)
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

## Resources

https://github.com/marcelloromani/dockerfiles/tree/main/ubuntu-ssh-server

https://serverfault.com/questions/1015547/what-causes-ssh-error-kex-exchange-identification-connection-closed-by-remote

