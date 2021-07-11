# README.md
Demonstrates configuring a nice prompt for `bash` and `zsh` inside a container

## Installation
```sh
# build and run
docker build -f Dockerfile -t nice_prompt . 
docker run --rm -it -d --name nice_prompt nice_prompt

# configure zsh theme
docker exec -it nice_prompt /bin/zsh       
nano ~/.zshrc 
ZSH_THEME="agnoster"
exit

# configure bash theme
docker exec -it nice_prompt /bin/bash
nano ~/.bashrc
OSH_THEME="agnoster"
exit
```

## Zsh
```sh
docker exec -it nice_prompt /bin/zsh  
```

## Bash
```sh
docker exec -it nice_prompt /bin/bash
```

# Resources 
* oh-my-zsh [here](https://ohmyz.sh/#install)  
* oh-my-bash [here](https://github.com/ohmybash/oh-my-bash)  
* locales [here](http://jaredmarkell.com/docker-and-locales/)