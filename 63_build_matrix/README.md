# README

Demonstrate creating a build matrix from a single container.  

## Run a build matrix on a Dockerfile

Use docker to run through a list of nginx versions and build them.  

```sh
# loop over versions of nginx
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    docker build --progress=plain --build-arg IMAGE=nginx:$NGINXVERSION --no-cache -t matrix$NGINXVERSIONSAFE .

    docker run -p 8080:80 --rm --name matrix$NGINXVERSIONSAFE -d matrix$NGINXVERSIONSAFE 
    curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server: 

    docker stop matrix$NGINXVERSIONSAFE
done
```

## Run a build matrix using compose

Docker Compose V2 is a plugin.  This can be installed on `apt` using `apt-get install -qq -y docker-compose-plugin`  

Same as above but using `compose`  

```sh
# show the profiles
docker compose config --profiles  

# loop over versions of nginx
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    docker compose --profile backend build --build-arg IMAGE=nginx:$NGINXVERSION

    # bring up profiles individually
    docker compose --profile backend up -d 
    curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server: 
    docker compose --profile backend down 
done
```

## Resources
