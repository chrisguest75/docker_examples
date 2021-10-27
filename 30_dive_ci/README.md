# README.md
Demonstrates using dive tool to analyse images.

## Prereqs
[Website](https://github.com/wagoodman/dive)   
```sh
# macos
brew install dive

# debian 
wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
sudo apt install ./dive_0.9.2_linux_amd64.deb
```

## Build image
```sh
docker build --no-cache -t passdivetest -f pass.Dockerfile .  
docker build --no-cache -t faildivetest -f fail.Dockerfile .  
```

## Analyse 
Analyse docker image in registry
```sh
# ubuntu 18.04 will pass
dive passdivetest --ci
# ubuntu 16.04 will pass
dive faildivetest --ci
```

Analyse from tar
```sh
# passdivetest
docker save passdivetest > passdivetest.tar
dive --source docker-archive passdivetest
# faildivetest
docker save faildivetest > faildivetest.tar
dive --source docker-archive faildivetest
```

# Resources
* Dive website [here]](https://github.com/wagoodman/dive)   

