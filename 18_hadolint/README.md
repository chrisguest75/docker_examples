# README.md
Demonstrates using [hadolint](https://github.com/hadolint/hadolint) which is a linting tool for Dockerfiles. 

## Installation
```sh
brew install hadolint
code --install-extension exiasr.hadolint
```

## Run linting on repo
```sh
# scan the whole repo
find $(git root)/* -iname Dockerfile -type f -exec hadolint {} \;
```

