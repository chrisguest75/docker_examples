# Script to follow
Demonstrate adding a file to a scratch base.    
Unpack the image tar and see how the file is stored in a layer. 

```
docker build -t scratchtest .
docker image save -o ./scratchtest.tar scratchtest

mkdir ./scratchtest
tar -xvf scratchtest.tar -C ./scratchtest
code ./scratchtest
```
