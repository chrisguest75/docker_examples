# README
Use remote-containers vscode extension

Hosting a basic webserver using bash inside a devcontainer

## Preparation
```sh
code --install-extension ms-vscode-remote.remote-containers
```

## Start
Select ```remote-containers: Open folder in container```

## Run

```sh
# Setup the server in the container
./webserver.sh 8080 "Hello from bash" &
```

```sh
# Make client request
curl -vvvv localhost:8080/clientpath
```

