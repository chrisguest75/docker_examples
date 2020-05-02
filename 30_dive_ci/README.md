# README.md
Demonstrates using dive tool to analyse images.

## Prereqs

```sh
brew install dive
```

## Build image
```sh
docker build --no-cache -t passdivetest -f pass.Dockerfile .  
docker build --no-cache -t faildivetest -f fail.Dockerfile .  
```

## Analyse 
Analyse docker image in registry
```sh
dive passdivetest --ci
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


