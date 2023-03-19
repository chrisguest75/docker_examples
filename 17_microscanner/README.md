# README

Demonstrate using microscanner to scan an image.  

NOTE: MicroScanner is now deprecated in favour of Trivy  

TODO:

* Can I scan all types of images?  Currently can only scan images where I can install the application.

## Script to follow

Follow instructions to register for an api token

[Microscanner](https://github.com/aquasecurity/microscanner)

```sh
docker build --build-arg microscannertoken=<API_TOKEN>
```

```sh
docker run -it --rm microscanner <API_TOKEN>
```
