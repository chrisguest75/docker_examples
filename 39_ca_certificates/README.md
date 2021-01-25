# Installing CA Certificates

TODO:
Nix example as it doesn't seem to work

```sh
docker build -f Dockerfile.ubuntu -t noca_ubuntu --target noca .
docker build -f Dockerfile.ubuntu -t withca_ubuntu --target withca .
```

```sh
dive noca_ubuntu --ci
docker run -it --entrypoint /bin/bash noca_ubuntu 
curl -vvvv https://www.google.com
curl -vvvv -k https://www.google.com
```

```sh
# 
dive withca_ubuntu --ci
docker run -it --entrypoint /bin/bash withca_ubuntu
curl -vvvv https://www.google.com
curl -vvvv -k https://www.google.com
```

ls -al /etc/ssl/certs