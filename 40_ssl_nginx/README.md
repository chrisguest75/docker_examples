# README
Create a self-signed ssl nginx endpoint for a container.  
Host the page from Docker on `testsite.local`

TODO:
* test ssl - tlsv1, tlsv1.2
* unaccept certificate

## Create Certificate Authority
Create a Certificate Authority 
```sh
# output directory for ca key and cert
mkdir -p ./ca    

# create the ca key (enter a passphrase)
openssl genrsa -des3 -out ./ca/chrisguestCA.key 2048

# create the ca certificate (fill in defaults)
# Common Name is what is displayed in macosx keychain
openssl req -x509 -new -nodes -key ./ca/chrisguestCA.key -sha256 -days 365 -out ./ca/chrisguestCA.pem
```

## Create Self-Signed Certificates
Create the self-sgned certificates
```sh
# output directory
mkdir -p ./certs    
cp ./testsite.local.ext ./certs/testsite.local.ext

# create the key
openssl genrsa -out ./certs/testsite.local.key 2048

# certificate signing request (fill in defaults and challenge password as "challenge")
openssl req -new -key ./certs/testsite.local.key -out ./certs/testsite.local.csr

# generate the ssl cert
openssl x509 -req -in ./certs/testsite.local.csr -CA ./ca/chrisguestCA.pem -CAkey ./ca/chrisguestCA.key -CAcreateserial \
-out ./certs/testsite.local.crt -days 825 -sha256 -extfile ./certs/testsite.local.ext
```
## Modify hosts

```sh
# edit hosts
sudo nano /etc/hosts 

# add an override to hosts
0.0.0.0         testsite.local
```

## Run the site
Build the example and host on localhost
```sh
# docker build 
docker build -t nginx_ssl -f Dockerfile.nginx_ssl .             
docker run -it --rm -d -p 8080:443 --name web nginx_ssl

# debian
xdg-open https://localhost:8080
xdg-open https://testsite.local:8080  

# macosx
open https://localhost:8080
open https://testsite.local:8080  

# curl will fail because of self signed
curl https://localhost:8080     
curl -k https://localhost:8080  
curl -k https://testsite.local:8080     
```

## Setup trust 
The CA will need to be added to local CA list
### Debian/Ubuntu 
```sh
#openssl x509 -outform der -in ./ca/chrisguestCA.pem -out ./ca/chrisguestCA.crt
#sudo cp ./ca/chrisguestCA.crt /usr/local/share/ca-certificates

sudo cp ./ca/chrisguestCA.pem /usr/local/share/ca-certificates/chrisguestCA.crt
sudo update-ca-certificates

cat /etc/ssl/certs/ca-certificates.crt      

# debian
xdg-open https://testsite.local:8080

# curl will should now not fail because of self signed
curl -vvvv https://testsite.local:8080     
```

### Debian/Ubuntu (chromium) 
```sh
# debian only
apt-get install libnss3-tools

# manual import (macosx manage certificates)
chrome://settings/certificates
```

### MacOSX (keychain trust)
```sh
# manual import (macosx manage certificates)
open chrome://settings/certificates

# open keychain
Import the ./ca/chrisguestCA.pem using File->Import Items

Find common name and select 'get info', select always trust
```

## Rotate certificate
```sh
# new certificate signing request (fill in defaults and challenge password as "challenge")
openssl req -new -key ./certs/testsite.local.key -out ./certs/testsite.local.csr

# generate the new ssl cert (now 1925 days)
openssl x509 -req -in ./certs/testsite.local.csr -CA ./ca/chrisguestCA.pem -CAkey ./ca/chrisguestCA.key -CAcreateserial \
-out ./certs/testsite.local.crt -days 1925 -sha256 -extfile ./certs/testsite.local.ext

# rotate the container
docker stop web
docker build -t nginx_ssl -f Dockerfile.nginx_ssl .             
docker run -it --rm -d -p 8080:443 --name web nginx_ssl

# check the date
curl -vvvv -k https://testsite.local:8080

# seems curl caches the certificate
open https://testsite.local:8080  
```

## Cleanup 
```sh
# kill container
docker stop web

# remove the host entry
sudo nano /etc/hosts 

# remove the certificates from keychain and ca-certificates
```

## Troubleshooting
```sh
# Get into container
docker exec -it web /bin/sh 

# exporting the certificate fields.
openssl x509 -in ./ca/chrisguestCA.pem -text   
openssl x509 -in ./certs/testsite.local.crt -text 
```

## Test SSL

```sh
https://github.com/drwetter/testssl.sh
```

# Resources 
* https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
* https://jamielinux.com/docs/openssl-certificate-authority/
* https://certificatetools.com/