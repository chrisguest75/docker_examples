# Troubleshooting

TODO:

* zfs issues
* installations

## Installs

Installing `docker` on different platforms doesn't always go well.  

## MacOS

It best to use docker desktop and keep it up-to-date.  

## Linux (ubuntu)

YMMV with Ubuntu standard package repositories. Official docs are [here] (https://docs.docker.com/engine/install/ubuntu/)  

Following instructions [here](ttps://www.omgubuntu.co.uk/how-to-install-docker-on-ubuntu-20-04)  

```sh
# install using docker.io
sudo apt install docker.io       

# if lvm is failing 
sudo apt purge lvm2
```

### Compose Plugin

Docker Compose V2 is a plugin.  This used to be installed on `apt` using `apt-get install -qq -y docker-compose-plugin`

But now following instructions [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)

```sh
mkdir -p ~/.docker/cli-plugins/

# download plugin
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

# run
docker compose version
```

## Raspbian

Following: https://www.simplilearn.com/tutorials/docker-tutorial/raspberry-pi-docker

Check https://get.docker.com/

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Resources

https://github.com/chrisguest75/rpi_examples