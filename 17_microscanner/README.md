# README.md
Demonstrate using microscanner to scan an image.  

# TODO
1. Can I scan all types of images?  Currently can only scan images where I can install the application.

## Script to follow
Follow instructions to register for an api token

[Microscanner](https://github.com/aquasecurity/microscanner)

```
docker build --build-arg microscannertoken=<API_TOKEN>
```


```
docker run -it --rm microscanner <API_TOKEN>
```