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
```sh
dive passdivetest --ci
dive faildivetest --ci
```

