# README

Demonstrate creating a build matrix from a single `dockerfile`.

Use a buildarg to pass in a baseimage that can be used to test multiple versions of code.  Or as in this example use different version of `nginx` base images  

## 🏠 Run a build matrix on a Dockerfile

Use docker to run through a list of nginx versions and build them.  

```sh
# loop over versions of nginx
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    # replace '.' with '_'
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    # build image
    docker build --progress=plain --build-arg IMAGE=nginx:$NGINXVERSION --no-cache -t matrix$NGINXVERSIONSAFE .

    # run image
    docker run -p 8080:80 --rm --name matrix$NGINXVERSIONSAFE -d matrix$NGINXVERSIONSAFE 

    # test (show version header)
    curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server: 

    # stop container
    docker stop matrix$NGINXVERSIONSAFE
done
```

## 🏠 Run a build matrix using compose

Docker Compose V2 is a plugin.  This can be installed on `apt` using `apt-get install -qq -y docker-compose-plugin`  

Same as above but using `compose`  

```sh
# show the profiles
docker compose config --profiles  

# loop over versions of nginx
for NGINXVERSION in 1.21.1 1.21.6 1.19.0; 
do
    # replace '.' with '_'
    NGINXVERSIONSAFE=$(echo $NGINXVERSION | sed "s/\./_/g")  

    # run image
    docker compose --profile backend build --build-arg IMAGE=nginx:$NGINXVERSION

    # bring up profiles individually
    docker compose --profile backend up -d 
    curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server:

    # bring down services  
    docker compose --profile backend down 
done
```

## 👀 Resources
