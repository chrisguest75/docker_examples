# README
Create an ssl proxy for a container.

TODO:
* trust self signed 
* test ssl - tlsv1, tlsv1.2
* unaccept certificate
* https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
* https://jamielinux.com/docs/openssl-certificate-authority/
* https://certificatetools.com/

## Create Certificate Authority
Create a CA 
```sh
# output directory
mkdir -p ./ca    

# create the ca key
openssl genrsa -des3 -out ./ca/chrisguestCA.key 2048

# 
openssl req -x509 -new -nodes -key ./ca/chrisguestCA.key -sha256 -days 365 -out ./ca/chrisguestCA.pem
```

## Create Self-Signed Certificates

```sh
mkdir -p ./certs    

openssl genrsa -out ./certs/testsite.local.key 2048

openssl req -new -key ./certs/testsite.local.key -out ./certs/testsite.local.csr

openssl x509 -req -in ./certs/testsite.local.csr -CA ./ca/chrisguestCA.pem -CAkey ./ca/chrisguestCA.key -CAcreateserial \
-out ./certs/testsite.local.crt -days 825 -sha256 -extfile ./certs/testsite.local.ext


```

```sh
# create self signed certs
# openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 365
```
## Modify hosts

```sh
# edit hosts
sudo nano /etc/hosts 

# add an override
0.0.0.0         testsite.local

```

## Run the site

```sh




# docker build 
docker build -t nginx_ssl -f Dockerfile.nginx_ssl .             
docker run -it --rm -d -p 8080:443 --name web nginx_ssl

# debian
xdg-open https://localhost:8080
# macosx
open https://localhost:8080

# curl will fail because of self signed
curl https://localhost:8080     
curl -k https://localhost:8080     

# kill container
docker stop web
```

## Test SSL

https://github.com/drwetter/testssl.sh



## Setup trust 





## Troubleshooting
```sh
docker exec -it web /bin/sh        
```