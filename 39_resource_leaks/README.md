# README
Attempt to get a container to resource leak on linux

How do I get into the 


```sh
# build 
docker build -t resource_leaks . 

# run
docker run -it --entrypoint /bin/bash resource_leaks  
```


free -h



while { echo -en "hello"; } | nc -l -p "5000"; do
  echo "================================================"
done &

telnet 0.0.0.0 5000
exit with ctrl+]
close

ss -l


https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/


## Outside container 

ps axjf

