# BUILDARGS

Demonstrate how buildargs are stored in the image.  Meaning anyone with access to the image will have access to the credentials.  With an example of new buildkit build time volume mounts to workaround this.  

Other examples to look at [58_secrets_apikey/README.md](58_secrets_apikey/README.md)  

## 📋 Script to follow

Build args are not part of the run time environment

```sh
# Build the image
docker build --progress=plain --no-cache --build-arg mygithubcreds=creds -t $(basename $(pwd)) .

# This will print out the internal environment variables.
docker run --rm $(basename $(pwd))
```

## 🤔 Analyse

We can see the secret in the history

```sh
# You will see the creds in the image history
docker history --no-trunc $(basename $(pwd)) | grep creds   
```

> Output

```log
48137c61225e        5 minutes ago       |1 mygithubcreds=creds /bin/sh -c echo ${myg…   0B                  
352371b94548        5 minutes ago       /bin/sh -c #(nop)  ARG mygithubcreds            0B      
```

Save a local copy of the image

```sh
docker image save -o ./$(basename $(pwd)).tar $(basename $(pwd))
```

Now examine the layers  

```sh
# Unpack the image
mkdir -p ./buildargstest && tar -xvf $(basename $(pwd)).tar -C $_
# Examine the structure
tree ./buildargstest
# Find the embedded credentials
find ./buildargstest/* -iname "*.json" -exec grep --color=always -H 'mygithubcreds=creds' {} \;
```

Find the "mygithubcreds" in the layer json files

```sh
code ./buildargstest
```

## 🧼 Clean up

```sh
# Remove files
rm -rf ./buildargstest
rm $(basename $(pwd)).tar
# remove image
docker rmi $(basename $(pwd))
```

## Docker buildkit secrets

[Buildkit Secrets Docs](https://docs.docker.com/develop/develop-images/build_enhancements/)  
To enable buildkit you can either **export DOCKER_BUILDKIT=1** or use **docker build buildx**

```sh
echo "export mygithubcreds=creds" > mysecret.txt
docker buildx build --no-cache -f $(pwd)/buildkit.Dockerfile --progress=plain --secret id=mysecret,src=mysecret.txt -t $(basename $(pwd)) .
unset DOCKER_BUILDKIT 
```

The build output from buildkit should contain the exported creds

```log
#10 [3/3] RUN --mount=type=secret,id=mysecret,dst=/tmp/mysecret.txt cat /tmp...
#10 0.310 export mygithubcreds=creds
#10 DONE 0.4s
```

If you repeat the analysis and cleanup sections above you'll see the secret is not contained in the metadata.  

## 👀 Resources

* Automatic platform ARGs in the global scope [here](https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope)
