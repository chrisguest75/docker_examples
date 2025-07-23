# CONTAINERD SNAPSHOTTER

Enable snapshotter to allow multiarch builds locally on Linux.

NOTES:

- I've had issues building and deploying lambda containers with SSTv2 with this enabled. It seems to be the cdk image it struggles with.

## Enable

```json
// cat /etc/docker/daemon.json
{
  "features": {
    "containerd-snapshotter": true
  }
}
```

## Restart Docker

```sh
sudo systemctl restart docker    
```

## Resources