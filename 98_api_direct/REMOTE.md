# API DIRECT

Demonstrate how to invoke the API directly.  

The Engine API is an HTTP API served by Docker Engine. It is the API the Docker client uses to communicate with the Engine, so everything the Docker client can do can be done with the API.  

## Host

### Linux

```sh
# linux
# docker.socket                    enabled  enabled
systemctl list-unit-files --type=socket
SOCKET=/run/docker.sock
curl --silent -XGET --unix-socket $SOCKET http://localhost/version | jq .
curl --silent -XGET --unix-socket $SOCKET http://localhost/containers/json | jq .
```

### MacOS

```sh
# mac
SOCKET=/var/run/docker.sock
curl --silent -XGET --unix-socket $SOCKET http://localhost/version | jq .

curl --silent -XGET --unix-socket $SOCKET http://localhost/containers/json | jq .  
```

## Resources

* Docker Engine API (1.43) [here](https://docs.docker.com/engine/api/v1.43/)
* How to query Docker socket using curl [here](https://sleeplessbeastie.eu/2021/12/13/how-to-query-docker-socket-using-curl/)
* Remote driver [here](https://docs.docker.com/build/drivers/remote/)
* dockerd [here](https://docs.docker.com/engine/reference/commandline/dockerd)
* [chrisguest75/sysadmin_examples/14_interrogate_resources/NETWORK.md](https://github.com/chrisguest75/sysadmin_examples/blob/master/14_interrogate_resources/NETWORK.md)
