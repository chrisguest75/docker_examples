# DISTROBOX

Create a distrobox

## Install

```sh
just nix

distrobox --help

distrobox list
```

## Test

```sh
just distrobox-create

distrobox enter archlinux

pacman -Q

distrobox rm archlinux
```

## Resources

* https://distrobox.it/
* https://github.com/89luca89/distrobox?tab=readme-ov-file#quick-start
* https://wiki.nixos.org/wiki/Distrobox