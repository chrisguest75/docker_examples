# README

Demonstrate creating a build matrix from a single container.

TODO:

* Render nginx version into the page.

## Run a build matrix on a Dockerfile

```sh
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    docker build --progress=plain --build-arg IMAGE=nginx:$NGINXVERSION --no-cache -t matrix$NGINXVERSIONSAFE .

    docker run -p 8080:80 --rm --name matrix$NGINXVERSIONSAFE -d matrix$NGINXVERSIONSAFE 
    # remove this and add retry to curl
    sleep 1       
    curl -Is http://0.0.0.0:8080 | grep Server: 
    #curl http://0.0.0.0:8080    
    docker stop matrix$NGINXVERSIONSAFE
done
```

## Run a build matrix using compose

Docker Compose V2 is a plugin.  This can be installed on `apt` using 
    `apt-get install -qq -y docker-compose-plugin`

```sh
# show the profiles
docker compose config --profiles  

for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    docker compose --profile backend build --build-arg IMAGE=nginx:$NGINXVERSION

    # bring up profiles individually
    docker compose --profile backend up -d 

    # remove this and add retry to curl
    sleep 1       
    curl -Is http://0.0.0.0:8080 | grep Server: 
    #curl http://0.0.0.0:8080    
    docker compose --profile backend down 
done

```




## Resources