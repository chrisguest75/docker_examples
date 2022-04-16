# README

Demonstrate creating a build matrix from a single container.

## Run a build matrix on a Dockerfile

```sh
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    docker build --progress=plain --build-arg IMAGE=nginx:$NGINXVERSION --no-cache -t matrix$NGINXVERSIONSAFE .

    docker run -p 8080:80 --rm --name matrix$NGINXVERSIONSAFE -d matrix$NGINXVERSIONSAFE 
    curl --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server: 

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
    sleep 1
    curl --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -I http://0.0.0.0:8080 | grep Server: 
    docker compose --profile backend down 
done
```

## Resources