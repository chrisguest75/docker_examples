# README

Demonstrate different ways to find distro versions inside a container

NOTES:

- Print out distro details.  
- Installing packages in distros.  
- `dnf` is replacement for `yum`.  
- Use [pkgs.org](https://pkgs.org) to determine latest package versions.  

TODO:

- work out ffmpeg7 install for almalinux (enterprise)
- Fix up the nix build
- Add a chainguard example
- Fix caching in alpine and fedora

## Contents

- [README](#readme)
  - [Contents](#contents)
  - [Distros](#distros)
  - [Builds](#builds)
  - [Troubleshooting](#troubleshooting)
  - [Resources](#resources)

## Distros

- Ubuntu
- Alpine
- Fedora
- Debian
- Nix
- Chainguard
- Almalinux

## Builds

Preprepared images where logs can be examined.  

```sh
just start [ubuntu|alpine|fedora|debian|nix|chainguard|almalinux] --no-cache
```

## Troubleshooting

```sh
# jump into a shell
just debug [ubuntu|alpine|fedora|debian|nix|chainguard|almalinux]
```

## Resources

- DNF vs. YUM: Learn the Differences [here](https://phoenixnap.com/kb/dnf-vs-yum)
- Alpine Linux /etc/apk/repositories Repositories file [here](https://www.cyberciti.biz/faq/alpine-linux-etc-apk-repositories-repositories-file/)
- Packages for Linux and Unix [here](https://pkgs.org)
