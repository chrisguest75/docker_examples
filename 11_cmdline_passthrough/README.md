# 11 - Cmdline passthrough

Demonstrate passing parameters and piping into docker run.

This helps to create oneliner docker commands. 

## 🏠 Build

```sh
docker build -t oneliner .
```

## ⚡️ Run simple command

Simple commands

```sh
docker run oneliner sleep 10  
docker run oneliner /bin/demo Hello from the demo.sh  
```

## ⚡️ Run command recieving pipe

Piping we have to make the run interactive.  

```sh
cat pipeable.sh | docker run -i oneliner /bin/pipeable

docker run -i oneliner /bin/pipeable < pipeable.sh

docker run -i oneliner /bin/pipeable <<EOF
HEREDOCS
EOF
```

> Output.

```log
[PIPED] #!/bin/sh
[PIPED] 
[PIPED] while IFS="" read -r line
[PIPED] do
[PIPED]   # shellcheck disable=SC2053
[PIPED]   echo "[PIPED] ${line}"
[PIPED] done
```

## 🏠 Build a default entrypoint

```sh
docker build -f default_entrypoint.Dockerfile -t default_pipeable .

docker run -i default_pipeable <<EOF
The default is the pipeable script.
But it can be overridden
EOF

docker run --entrypoint=demo default_pipeable Overiding the entrypoint
```

