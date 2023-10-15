# CMDLINE PASSTHROUGH

Demonstrate passing parameters and piping data into docker run.

This helps to create oneliner docker commands.  

## 🏠 Build

```sh
# build 
docker build -t oneliner .
```

## ⚡️ Run simple command

Simple commands

```sh
# sleep for 10 seconds
docker run oneliner sleep 10  

# run a script and pass in a parameter
docker run oneliner /bin/demo Hello from the demo.sh  
```

## ⚡️ Run command recieving pipe

Piping we have to make the run interactive.  

```sh
# pipe a file into a container (with parameters as well)
cat pipeable.sh | docker run -i oneliner /bin/pipeable test1 test2

# pipe a file into a container
docker run -i oneliner /bin/pipeable < pipeable.sh

# pipe heredoc
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
