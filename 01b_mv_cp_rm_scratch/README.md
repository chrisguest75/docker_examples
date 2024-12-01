# Mv, Rm, Sh Scratch

Try copying files in a scratch container.  

ℹ️ NOTES:

* Probably easier to build a rootfs and copy the files into the tar.  
* This can alos be achieved using multi-stage far easier.  
* Busybox is an all in one build of lots of shell tools.  

## 📋 Script to follow

Busybox copying fails to work.  

```sh
just build

just dive

just debug
```

## Resources

* BusyBox: The Swiss Army Knife of Embedded Linux [here](https://www.busybox.net/FAQ.html)
