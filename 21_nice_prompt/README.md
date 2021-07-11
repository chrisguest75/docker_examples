# README.md
Demonstrates configuring a nice prompt inside a container

TODO:
* Configure bash and zsh inside the container
* Locales

## Installation
```sh
docker build -f Dockerfile -t nice_prompt . 
```

## Zsh

```sh
docker run -it --entrypoint /bin/zsh nice_prompt

nano ~/.zshrc 

ZSH_THEME="agnoster"

zsh
```

## Bash

```sh
docker run -it --entrypoint /bin/bash nice_prompt

nano ~/.bashrc

OSH_THEME="agnoster"

bash
```

# Resources 

* oh-my-zsh [here](https://ohmyz.sh/#install)  
* oh-my-bash [here](https://github.com/ohmybash/oh-my-bash)  


