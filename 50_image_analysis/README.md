# README.md
Demonstrate a container that can be used to generate a complete report on an image.  

All in one image Using:
* DinD [README.md](../46_dind/README.md)  
* Dockle [README.md](../22_dockle/README.md)  
* DiveCI [README.md](../30_dive/README.md)  
* Trivy
* Grype
* Labels extraction
* Structure tests
* Docker Scan [README.md](../45_docker_scan_process_mongo/README.md)  
* Policy Verification

## Examples

```sh
docker build -t analysis .
docker run --privileged -it --entrypoint /bin/bash analysis
```


# dockle
https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
https://github.com/goodwithtech/dockle/releases/tag/v0.3.15

wget $(curl -s https://api.github.com/repos/goodwithtech/dockle/releases/latest | grep "browser_download_url.*\/dockle_0.3.15_Linux-64bit\.apk" | cut -d : -f 2,3 | tr -d \")
apk add --allow-untrusted dockle_0.3.15_Linux-64bit.apk 


wget https://github.com/goodwithtech/dockle/releases/download/v0.3.15/dockle_0.3.15_Linux-64bit.apk
apk add --allow-untrusted dockle_0.3.15_Linux-64bit.apk 

# dive 
wget https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.tar.gz
sudo apt install ./dive_0.9.2_linux_amd64.deb

dive_0.10.0_linux_amd64.tar.gz



# Resources
