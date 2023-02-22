# WASI

Demonstrate how to setup a WASI based container.  

TODO:

* How do I pass dir to docker `wasmtime --dir . ./build/debug.wasm`

NOTES:

* This only runs on docker with `containerd` activated.  
 
## Reason

Using WASM allows us to run small containers on multiple architectures.  

One of the benefits of using Wasm containers is that they provide a secure and isolated environment for running code. Because Wasm code is executed in a sandboxed environment, it is protected from the rest of the system and cannot access resources or data outside of its sandbox. This can help prevent malicious code from causing damage to the host system or stealing sensitive information.  

## Prereqs

```sh
brew install wasmtime

# ContainerD needs to be enabled (check for runc). 
docker info 
```

## Run

```sh
# build wasm from assemblyscript
npm run asbuild:debug -- --use abort=assembly/index/myAbort

# start locally using wasmtime
npm run start
```

## Docker

NOTE: The challenge of building in a container is that we need to switch architectures during the build.  

```sh
# build using local files
npm run docker:build

# build in a container
npm run docker:buildwasm

npm run docker:start
```

## Created

```sh
# using asinit we create a template
npm install -g assemblyscript

./node_modules/.bin/asinit 86_wasi
```

## Resources

* WASM Docker Desktop [here](https://docs.docker.com/desktop/wasm/)
* WASMTime [here](https://github.com/bytecodealliance/wasmtime)
* Getting started with Docker + Wasm [here](https://nigelpoulton.com/getting-started-with-docker-and-wasm/)  
* WebAssembly System Interface (WASI) Node [here](https://nodejs.org/api/wasi.html)  
*  The AssemblyScript Book Examples [here](https://www.assemblyscript.org/examples.html)  
* WASM by Example WASI Hello World [here](https://wasmbyexample.dev/examples/wasi-hello-world/wasi-hello-world.assemblyscript.en-us.html)   
* A high-level AssemblyScript layer for the WebAssembly System Interface (WASI) [here](https://github.com/jedisct1/as-wasi)  
* WasmEdge is a lightweight, high-performance, and extensible WebAssembly runtime. [here](https://github.com/WasmEdge/WasmEdge)  
* as-wasi fails to build with v0.20.0 #2259 [here](https://github.com/AssemblyScript/assemblyscript/issues/2259)  
* Importing the correct Wasi module in node.js [here](https://stackoverflow.com/questions/72545867/importing-the-correct-wasi-module-in-node-js)  
* Stand-Alone WebAssembly Runtime Support? #967 [here](https://github.com/AssemblyScript/assemblyscript/issues/967)
* can't pull images while building with buildx 'failed to do request', 'i/o timeout' #191 [here](https://github.com/docker/buildx/issues/191)
