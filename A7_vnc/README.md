# VNC

Demonstrate running VNC in a docker container.  

NOTES:

* When we create HEREDOCS they are created with an encoding that does not work with X.  

TODO:

* Install a window manager and setbg picture

## Run

```sh
# build
just docker-build vnc

# run
just docker-run vnc

# shell
just docker-shell vnc
```

## Client

On GNOME you can use `connection` GUI client.  

## Resources

* Run GUI Applications in a Docker Container [here](https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638)
* X11 apps package [here](https://launchpad.net/ubuntu/noble/amd64/x11-apps/7.7+9)
