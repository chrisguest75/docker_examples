# README
Demonstrate some examples of using `trivy`.

NOTE: The schema version seems to have changed and this is broken now. 

For reducing number of vulnerabilities refer to:
* Distroless [README.md](../28_distroless/README.md)  
* Nix [README.md](https://github.com/chrisguest75/nix-examples/blob/master/README.md)  

Other scanning examples:
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  
* Grype [README.md](../49_grype/README.md)  

## Prerequisites
```sh
# install trivy
brew install aquasecurity/trivy/trivy
```

## Script to scan many and create report
```sh
# scan images listed in `images_to_scan.json`
./scan.sh

# open index.html in vscode and open live server
```


## Liveserver in vscode
Use the live share extension.  
The example uses a `./scans/out/images_trivy.json` file that has to be served up from a webserver.

```sh 
# use a live server to server up pages that have resources
code --install-extension ritwickdey.LiveServer
```


# Resources 
* trivy docs [here](https://aquasecurity.github.io/trivy/v0.18.3/installation/)  
* container-vulnerability-scanning-with-trivy [here](https://www.bluetab.net/en/container-vulnerability-scanning-with-trivy/)  
