# README.md
Demonstrates configuring a nice prompt for `bash` and `zsh` inside a container

## Installation
```sh
# build and run
docker build -f Dockerfile -t nice_prompt . 
docker run --rm -it -d --name nice_prompt nice_prompt

# configure zsh theme
docker exec -it nice_prompt /bin/zsh   

# modify the configs (zsh)
cp ~/.zshrc ~/.zshrc.bak
cat ~/.zshrc.bak | sed 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' > ~/.zshrc

# modify the configs (bash)
cp ~/.bashrc ~/.bashrc.bak
cat ~/.bashrc.bak | sed 's/OSH_THEME="font"/OSH_THEME="agnoster"/g' > ~/.bashrc

# can verify the changes
nano ~/.zshrc 
nano ~/.bashrc
exit
```

## Zsh
```sh
# run zsh
docker exec -it nice_prompt /bin/zsh  
```

## Bash
```sh
# run bash
docker exec -it nice_prompt /bin/bash
```

## Cleanup
```sh
# cleanup the container
docker stop nice_prompt 
```


# Resources 
* oh-my-zsh [here](https://ohmyz.sh/#install)  
* oh-my-bash [here](https://github.com/ohmybash/oh-my-bash)  
* locales [here](http://jaredmarkell.com/docker-and-locales/)