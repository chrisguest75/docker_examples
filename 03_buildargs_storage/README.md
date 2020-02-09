## Example 3 - Buildargs 
Demonstrate how buildargs are stored in the image. 
Meaning anyone with access to the image will have access to the credentials

TODO:
    1. *Can I prove that you can escape a root container to find it?* 

# Script to follow
Build args are not part of the run time environment
```sh
# Build the image
docker build --build-arg mygithubcreds=creds -t scratchtest .
# This will print out the internal environment variables.
docker run scratchtest
```

Save a local copy of the image
```sh
docker image save -o ./scratchtest.tar scratchtest
```

Now examine the layers  
```sh
# Unpack the image
mkdir -p ./scratchtest && tar -xvf scratchtest.tar -C $_
# Examine the structure
tree ./scratchtest
# Find the embedded credentials
find ./scratchtest/* -iname "*.json" -exec grep --color=always -H 'mygithubcreds=creds' {} \;
```

Find the "mygithubcreds" in the layer json files
```sh
code ./scratchtest
```

