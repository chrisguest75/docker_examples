# README

Demonstrate creating a build matrix from a single container.

TODO:

* Print agent headers
* Create a build matrix 
* Render nginx version into the page.


```sh
docker build --progress=plain --build-arg IMAGE=nginx:1.21.1 --no-cache -t matrix1.21.1 .

docker run -p 8080:80 --rm --name matrix1.21.1 -d matrix1.21.1        
curl http://0.0.0.0:8080    
docker stop matrix1.21.1


docker build --progress=plain --build-arg IMAGE=nginx:1.21.6 --no-cache -t matrix1.21.6 .
```

## Resources