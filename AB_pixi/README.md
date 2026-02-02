# PIXI

Demonstrate using `pixi` package manager from [pixi.prefix.dev](https://pixi.prefix.dev/).

TODO:

* Install software.
* Devcontainer
* Creating own packages
* Build a lightweight container.
* uv, python

## Playground

Start from scratch

```sh
# it will enter the playground folder 
just pixi-example playground

# create the pixi.toml file
pixi init
```

## Examples

### ffmpeg

```sh
just pixi-example ffmpeg
```

### Python

```sh
just pixi-example python3.14 

# enter shell
pixi shell
python ./main.py
```

### uv

From scratch:

```sh
just pixi-example playground
pixi init
pixi add uv
pixi shell 
uv init
uv add requests
```

From uv example:

```sh
just pixi-example uv
pixi shell
uv sync
uv run main.py
```

## Resources

* https://github.com/pavelzw/pixi-docker-example
* https://pixi.prefix.dev/latest/deployment/pixi_pack/
* https://pixi.prefix.dev/latest/workspace/lockfile/#how-to-use-a-lock-file
* https://pixi.prefix.dev/latest/reference/pixi_configuration/#run-post-link-scripts