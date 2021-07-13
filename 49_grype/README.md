# README
Demonstrate some examples of using `grype`.  
NOTE: This merges `negligible` into `low` and `unknown` into `high` classifications  


For reducing number of vulnerabilities refer to:
* Distroless [README.md](../28_distroless/README.md)  
* Nix [README.md](https://github.com/chrisguest75/nix-examples/blob/master/README.md)  

Other scanning examples:
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  
* Trivy [README.md](../48_trivy/README.md)  

TODO:
* docker:20.10.7-dind is broken
* When using grype in a loop it quits for some reason....... Not sure what this is or how to work out what is wrong..

## Prerequisites
```sh
# install grype
brew tap anchore/grype
brew install grype
```

## Script to scan many and create report
```sh
# scan images listed in `images_to_scan.json`
./scan.sh

# open index.html in vscode and open live server
```

## Liveserver in vscode
Use the live share extension.  
The example uses a `./scans/out/images_docker.json` file that has to be served up from a webserver.

```sh 
# use a live server to server up pages that have resources
code --install-extension ritwickdey.LiveServer
```

# Resources 
* grype docs [here](https://github.com/anchore/grype)  