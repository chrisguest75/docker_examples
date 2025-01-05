# X11 AND WAYLAND

Demonstrate how to run X11 applications in a docker container.  

TODO:

* Browsers
* Get x11 and wayland working
* VNC
* ssh to x11 container
* Test on mac, nix and wsl

## Run

```sh
# run installs xhost cmd
just nix
# run
just docker-run xcalc
just docker-run tools xlogo
just docker-run tools ico

# shell
just docker-shell xcalc
```

## Resources

* GUI app in Docker container [here](https://discourse.nixos.org/t/gui-app-in-docker-container/40939/5)
* X11 apps package [here](https://launchpad.net/ubuntu/noble/amd64/x11-apps/7.7+9)
* How can I run a graphical application in a container under Wayland? [here](https://unix.stackexchange.com/questions/330366/how-can-i-run-a-graphical-application-in-a-container-under-wayland)
* Running GUI apps within Docker containers [here](https://news.ycombinator.com/item?id=30810410)
* X11 forwarding of a GUI app running in docker [here](https://stackoverflow.com/questions/44429394/x11-forwarding-of-a-gui-app-running-in-docker)
* Run GUI Applications in a Docker Container [here](https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638)
* Running GUI apps with Docker [here](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)