# OCI Images

Build an example of using OCI registry as a package manager for chainguard.  

Related [81_oras](../81_oras/README.md)  
Related [94_regctl](../94_regctl/README.md)  

TODO:

* Build a volume containing lots of deb and apk files
* Build a base image
* Build a tarball

## Contents

- [OCI Images](#oci-images)
  - [Contents](#contents)
  - [Tarball](#tarball)
    - [Create](#create)
    - [Push](#push)
  - [Resources](#resources)

## Tarball

Generate a bunch of files with leading zeros.  

### Create

```sh
file="pkg"
extension="apk"
outpath="./out/packages/"
mkdir -p ${outpath}
for index in $(seq 0 10); 
do
    filepath=`printf %s%s%04d.%s ${outpath} ${file} ${index} ${extension}`
    echo "Creating ${filepath}"
    dd if=/dev/urandom of=$filepath bs=1024 count=1
    #touch $filepath
    sleep 1
done

tar -czvf ./out/packages.tar.gz ./out/packages/
tar -tf ./out/packages.tar.gz
ll -a ./out/packages.tar.gz
```

### Push

```sh
./bins/regctl-darwin-amd64 artifact put registry-1.docker.io/chrisguest/demo --file ./README.md --artifact-type application/vnd.oci.readme.md
```


## Resources

