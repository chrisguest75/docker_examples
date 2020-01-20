# README.md
Demonstrates using [hadolint](https://github.com/hadolint/hadolint) which is a linting tool for Dockerfiles. 

## Installation
```
brew install hadolint
code --install-extension exiasr.hadolint
```

## Run linting on repo
```
find ../* -iname Dockerfile -type f -exec hadolint {} \;
```

