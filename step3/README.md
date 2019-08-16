# Script to follow
*Can I prove that you can escape a root container to find it?* 

```
docker build -t scratchtest .

docker build --build-arg mygithubcreds=creds -t scratchtest .

docker run scratchtest

docker image save -o ./scratchtest.tar scratchtest

mkdir ./scratchtest
tar -xvf scratchtest.tar -C ./scratchtest
code ./scratchtest



```