# Script to follow

docker build  -t scratchtest .
docker image save -o ./scratchtest.tar scratchtest

mkdir ./scratchtest
tar -xvf scratchtest.tar -C ./scratchtest

