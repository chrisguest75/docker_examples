# X11 AND WAYLAND

TODO:

* Browsers
* Get x11 and wayland working
* VNC
* ssh

## Run

```sh
# build
just docker-build xcalc

# run
just docker-run xcalc

# shell
just docker-shell xcalc
```

## Resources

* X11 apps package [here](https://launchpad.net/ubuntu/noble/amd64/x11-apps/7.7+9)
* https://unix.stackexchange.com/questions/330366/how-can-i-run-a-graphical-application-in-a-container-under-wayland
* https://news.ycombinator.com/item?id=30810410
* https://stackoverflow.com/questions/44429394/x11-forwarding-of-a-gui-app-running-in-docker
* https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638
* http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/