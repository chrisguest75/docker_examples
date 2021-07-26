# README
Use remote-containers vscode extension

Hosting a basic webserver using bash inside a devcontainer

## Preparation
```sh
# install the extension
code --install-extension ms-vscode-remote.remote-containers
```

## Start
Select ```remote-containers: Open folder in container``` and open the `41_remote_containers` folder. 

## Run

```sh
# The container is setup to run a simple netcat webserver in the container
./webserver.sh 8080 "Hello from bash" &
```

```sh
# Make client request on the host
curl -vvvv localhost:8080/clientpath
```

# Resources 
* remote-overview docs [here](https://code.visualstudio.com/docs/remote/remote-overview)  
* remote containers docs [here](https://code.visualstudio.com/docs/remote/containers)  