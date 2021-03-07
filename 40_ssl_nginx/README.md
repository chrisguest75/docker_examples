# README
Create an ssl proxy for a container.

TODO:
* trust 

```sh
# create self signed certs
openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 365

# docker build 
docker build -t nginx_ssl -f Dockerfile.nginx_ssl .             
docker run -it --rm -d -p 8080:443 --name web nginx_ssl

# debian
xdg-open https://localhost:8080
# macosx
open https://localhost:8080

# kill container
docker stop web
```

## Troubleshooting
```sh
docker exec -it web /bin/sh        
```