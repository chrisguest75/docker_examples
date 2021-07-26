# README
Use remote-containers vscode extension to create a nodejs and mongodb container

Hosting a basic webserver using nodejs and mongo inside a devcontainer

## Preparation
```sh
# install the extension
code --install-extension ms-vscode-remote.remote-containers
```

## Create Container
Select `Remote-Containers: Add Development Container Configuration File` 

## Start
```sh
# open the root of the git repo
code $(git root)
```

Select `Remote-Containers: Open folder in container` and open the `41_nodejs_remote_devcontainer` folder. 

## Create the service app
```sh
# install express generator
npm install -g express-generator
```

```sh
# create a simple sevice
express -c stylus -v hjs mongo_demo  
cd mongo_demo/
npm install 
```

```sh
# run the express app
DEBUG=mongo_demo:* npm start
open http://localhost:3000
```


add mongo 
create an endpoint that inserts data
create an endpoint that reads data


# Resources 
* remote-overview docs [here](https://code.visualstudio.com/docs/remote/remote-overview)  
* remote containers docs [here](https://code.visualstudio.com/docs/remote/containers)  