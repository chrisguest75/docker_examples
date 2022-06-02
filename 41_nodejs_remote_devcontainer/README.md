# README

Use remote-containers vscode extension to create a nodejs and mongodb container

Hosting a basic webserver using nodejs and mongo inside a devcontainer

Quick summary:

* The devcontainer is the container we do dev work in - not what we ship.  
* MongoDB will be in the same network namespace as the Node App - but also both ports are open on host.
* You can use the node debugger using the launch.json.  

Warning:

* I have had the container disconnect and I lost unsaved work.

TODO:

* Add an dataloading test
* parameterise passwords
* Killing the volumes
* Packaging the containers up for production.  
* Sharing the devcontainer between machines.

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
# run the express app (inside `mongo_demo`)
DEBUG=mongo_demo:* npm start

# on the host
open http://localhost:3000

# in the dev container.
mongo -u root -p rootpassword
```

```sh
# add mongo and dotenv (inside `mongo_demo`)
npm install mongo dotenv
npm install -g nodemon

nodemon npm start
```

## Test the endpoints

```sh
# Post some data into DB
curl -X POST localhost:3000/api/test    
```

```sh
# Read the data
curl -X GET localhost:3000/api/test    
```

```sh
# render the page.
open http://localhost:3000/api/test  

# render the root page
open http://localhost:3000
```

## Using node debugger in vscode

You can use the node debugger using the launch.json.  

## Packaging up for release

Once you have used the devcontainer to develop the code.  You now use a different set of containers to package up the final code.  These are the images you would push.

```sh
# start the packaged version
docker compose --profile backend up -d

# rebuild it
docker compose --profile backend build 

# clean it up
docker compose --profile backend down --volumes  
```

## Troubleshooting

Investigating MongoDB  

ℹ NOTE: If the db is failing to create correctly you might need to remove the containers and volume  

```sh
docker ps
docker volume ls
```

```sh
# exec into container
docker exec -it $(docker ps --filter name=nodejs_remote_devcontainer_devcontainer_db_1 -q) /bin/sh
# login to mongo
mongosh -u root -p rootpassword
show dbs
```

```js
// removing items from the collection
db.getCollection('test').find()
db.getCollection('test').remove({})

// if volume has indices 
db.getCollection('test').getIndexes()
db.getCollection('test').dropIndexes(["id_1"])
```

## Resources

* remote-overview docs [here](https://code.visualstudio.com/docs/remote/remote-overview)  
* remote containers docs [here](https://code.visualstudio.com/docs/remote/containers)  
