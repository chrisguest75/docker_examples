# Docker Build Examples and Demos

A repository for showing examples of how Docker builds containers and how tools fit into the ecosystem.  Working through examples to demonstrate and prove concepts that exist.  

The aim is to use examples to show how Docker behaves when building containers and to highlight incorrect assumptions about behaviour.  

## Example 0 - Cheatsheet

Cheatsheet style helpers for common tasks.  
Steps [README.md](./00_cheatsheet/README.md)  

## Example 1 - Layers, Hiding and Squashing

Demonstrates how layers are stored, files are hidden and can be squashed.  
Steps [README.md](./01_layers_hiding/README.md)  

## Example 1b - Mv, Rm, Sh

** Not working!! **  
Building a simple container with mv, rm, sh.  Probably missing libs.  
Steps [README.md](./01b_mv_cp_rm/README.md)  

## Example 2 - Host and Kernel details

Demonstrates how kernel versions are different for build and execution.  
Steps [README.md](./02_host_and_kernel/README.md)  

## Example 3 - Buildargs

Demonstrate how buildargs are stored in the image.  Meaning anyone with access to the image will have access to the credentials.  With an example of new buildkit build time volume mounts to workaround this.  
Steps [README.md](./03_buildargs_storage/README.md)  

## Example 4 - Docker Context

Show a docker context issue (large files)  
Steps [README.md](./04_docker_context/README.md)  

## Example 5 - Root user

Demonstrate root user and privilege inside the container.  
Steps [README.md](./05_root_user/README.md)  

## Example 6 - Multistage small image size

Demonstrate multistage build small image size  
Steps [README.md](./06_multistage/README.md)  

## Example 7 - Buildkit

Demonstrate buildkit parallel building  
Steps [README.md](./07_buildkit_parallelbuilds/README.md)  

## Example 8 - Layer caching with arguments

Demonstrate layer caching and how different build arguments values will not be cached until built.  
Steps [README.md](./08_caching_arguments/README.md)  

## Example 9 - Kaniko

Demonstrate using Kaniko to build a Docker image  
Steps [README.md](./09_kaniko/README.md)  

## Example 10 - Distro Versions

Demonstrate different ways to find distro versions inside a container  
Steps [README.md](./10_distro_versions/README.md)  

## Example 11 - Parameters and piping passthrough

Demonstrate passing parameters and piping into docker run.  
Steps [README.md](./11_cmdline_passthrough/README.md)  

## Example 12 - Background processes

Demonstrate creating background processes  
Steps [README.md](./12_background_processes/README.md)  

## Example 13 - Users and permissions

Users and permissions  
Steps [README.md](./13_users_and_permissions/README.md)  

## Example 14 - OOM - Out of memory

Demonstrate an out of memory issue.  Includes sysdig...  
Steps [README.md](./14_out_of_memory/README.md)  

## Example 15 - ENTRYPOINT and CMD

Demonstrate how ENTRYPOINT and CMD differ  
Steps [README.md](./15_entrypoint_and_cmd/README.md)  

## Example 16 - Layer caching with non-deterministic executions

Demonstrate how layer caching works with non-determinstic commands.  
Steps [README.md](./16_cache_fails/README.md)  

## Example 17 - Microscanner

Demonstrate how to use Microscanner to detect vulnerabilities.  
Steps [README.md](./17_microscanner/README.md)  

## Example 18 - Hadolint

Demonstrate hadolint  
Steps [README.md](./18_hadolint/README.md)  

## Example 19 - Locking versions with APT

Demonstrate an apt locking technique  
Steps [README.md](./19_apt_locking/README.md)  

## Example 20 - Building a rootfs image

Demonstrates building a root image  
Steps [README.md](./20_build_root/README.md)  

## Example 21 - Nice prompts

Demonstrates configuring a nice prompt for `bash` and `zsh` inside a container  
Steps [README.md](./21_nice_prompts/README.md)  
## Example 22 - Example of using dockle

Demonstrates using dockle to find issues with images.  
Steps [README.md](./22_dockle/README.md)  

## Example 23 - Building bash5 for Unbuntu 16.04

Demonstrates building bash 5 on an ubuntu image.  
Steps [README.md](./23_bash5_ubuntu/README.md)  

## Example 24 - Reverse shells

Demonstrates getting access into a container  
Steps [README.md](./24_reverse_shell/README.md)  

## Example 25 - Apparmor

Demonstrates using Apparmor to restrict processes in a container.  
Steps [README.md](./25_apparmor/README.md)  

## Example 26 - Sidecar debugging

Demonstrates sidecar techniques for debugging  
Steps [README.md](./26_sidecar_debugging/README.md)  

## Example 27 - Readonly containers

Demonstrates a readonly container  
Steps [README.md](./27_readonly_containers/README.md)  

## Example 28 - Distroless

Demonstrates a distroless container build  
Steps [README.md](./28_distroless/README.md)  

## Example 29 - Workflow feature flags

A technique to use in CI systems where it is not possible to parameterise the workflow/pipeline.  
Steps [README.md](./29_workflow_feature_flags/README.md)  
## Example 30 - Dive CI Tool

Demonstrates using dive tool to analyse images.  
Steps [README.md](./30_dive_ci/README.md)  

## Example 31 - Structure Tests

Demonstrates how to use container structure testing.  
Steps [README.md](./31_structure_tests/README.md)  

## Example 32 - File extraction

Demonstrates copying data out of container images.  
Steps [README.md](./32_file_extraction/README.md)  

## Example 33 - Label metadata

Demonstrates adding label metadata to builds that helps us trace pipelines and build sources.  
Steps [README.md](./33_label_metadata/README.md)  

## Example 34 - Volume Images

Demonstrates how to configure an image that can be mounted as a volume into a container.  
Steps [README.md](./34_volume_images/README.md)  

## Example 35 - Layer Poisoning

Demonstrate how to inject file into multiple running containers from host.  
Steps [README.md](./35_layer_poisoning/README.md)  

## Example 36 - Layers Speed Tests

Demonstrates timing differences with layers building and running  
Steps [README.md](./36_layers_speed/README.md)  

## Example 37 - Registry Proxy

Demonstrate how to run a pull through registry proxy.  
Steps [README.md](./37_registry_proxy/README.md)  

## Example 38 - Alpine APK

Demonstrate how to install a custom package in Alpine.  
Steps [README.md](./38_alpine_apk/README.md)  

## Example 39 - SSH

Demonstrate how to use `ssh` inside a docker container  
Steps [README.md](./39_ssh/README.md)  

## Example 40 - SSL nginx

Create a self-signed ssl nginx endpoint for a container.  
Steps [README.md](./40_ssl_nginx/README.md)  

## Example 41 - DevContainers

Use remote-containers vscode extension  
Steps [README.md](./41_remote_containers/README.md)  

## Example 41 - NodeJS DevContainers

Use remote-containers vscode extension to create a nodejs and mongodb container  
Steps [README.md](./41_nodejs_remote_devcontainer/README.md)  

## Example 42 - Docker systemd service

Demonstrate how to use docker containers as systemd.  
Steps [README.md](./42_docker_systemd_service/README.md)  

## Example 43 - Buildpacks

Demonstrate how to use a build pack to build a simple Python container  
Steps [README.md](./43_buildpacks/README.md)  

## Example 44 - Reverse Proxy

Demonstrate a simple reverse proxy to manage build deployments  
Steps [README.md](./44_reverse_proxy/README.md)  

## Example 45 - Docker Scan

Demonstrate some examples of using `docker scan`.  
Steps [README.md](./45_docker_scan/README.md)  

## Example 46 - Docker in Docker (DinD)

Demonstrate how to use Docker in Docker  
Steps [README.md](./46_dind/README.md)  

## Example 48 - trivy

Demonstrate some examples of using `trivy`.  
Steps [README.md](./48_trivy/README.md)  

## Example 49 - grype

Demonstrate some examples of using `grype`.  
Steps [README.md](./49_grype/README.md)  

## Example 51 - Signals

Demonstrate how signals work in containers  
Steps [README.md](./51_signals/README.md)  

## Example 52 - docker-slim

Demonstrate dockerslim and how to use it to reduce container sizes.  
Steps [README.md](./52_dockerslim/README.md)  

## Example 53 - seccomp and apparmor

Demonstrate seccomp and apparmor and how to use them.  
Steps [README.md](./53_seccomp_and_apparmor/README.md)  

## Example 54 - semgrep

Demonstrate semgrep on dockerfile and other standard container resources  
Steps [README.md](./54_semgrep/README.md)  

## Example 55 - multiarch

Demonstrate building and running multi-arch images  
Steps [README.md](./55_multiarch/README.md)  

## Example 57 - ssh builds using ssh-agent

Demonstrate how to use an ssh mount during build.  
Steps [README.md](./57_ssh_build_with_sshagent/README.md)  

## Example 56 - pyenv versions

Demonstrate how to get `pyenv` installing a particular version in a container  
Steps [README.md](./56_pyenv_versions/README.md)  

## Example 57 - Using SSH during build

Demonstrate how to use an ssh mount during build.  
Steps [README.md](./57_ssh_build_with_sshagent/README.md)  

## Example 58 - Secrets API key

Demonstrate how to use a secrets mount during build (requires buildkit).  
Steps [README.md](./58_secrets_apikey/README.md)  

## Example 59 - Compose V2 examples

Demonstrate how to use docker compose v2.  
Steps [README.md](./59_composev2/README.md)  

## Example 60 - heredocs

Demonstrate how to use HEREDOC in a Dockerfile.  
Steps [README.md](./60_heredocs/README.md)  

## TODO

1. skopeo
1. botb - break out the box image https://github.com/brompwnie/botb
1. Add a basic setup and tooling  00_starting
1. Show how multistage builds work for testing
1. Demo using cache-from.....  Use a timed layer.
1. Use different CAPS_SYS parameters.
1. Build a apt-mirror https://www.tecmint.com/setup-local-repositories-in-ubuntu/
1. Content trust
1. Speed of different file system layers.  i.e. If we have a 1000 layers how fast is it to find a file?
1. cgroups and namespaces
1. Diffing using different tools https://docs.docker.com/engine/reference/commandline/diff/
1. Kaniko. Caching, speed?  
1. Calculating accurate image sizes - looks like container-diff can output this.
1. Docker registry v2 examples. https://www.slideshare.net/Docker/docker-registry-v2  
1. Docker container escape with docker copy.
https://www.andreafortuna.org/2019/11/26/cve-2019-14271-a-docker-cp-container-escape-vulnerability/
1. Add procdump to the sidecar
1. PID1 - init-system https://cloud.google.com/solutions/best-practices-for-building-containers
1. mounting volumes and permissions.
1. Build a busybox image.  https://github.com/ukanth/afwall/wiki/HOWTO-Compiling-busybox
1. Create a layer and add it manually to the image
1. Docker content trust https://docs.docker.com/engine/security/trust/content_trust/
1. Show patching a container to fix an issue reported by GCR
1. Cache invalidation - package managers
1. Ordering of layers
1. onbuild
1. Signing builds
1. Build software using qemu and copy it in.
1. Unpack the filesystem flattened.  Filesystem view in a single container.
1. Start a cgroup manually using an unpacked container.
1. Snaps??
1. Showing the process tree for docker
1. Cron in a container.
1. memory restrictions and how they manifest.
1. Can I use a cgroup command inside a container?
1. Docker users.
1. Binding to different networks localhost vs 127.0.0.1 or 0.0.0.0
1. docker info
1. docker context
1. docker plugins.
1. nginx letsencrypt
1. docker manifests
1. CRFS: Container Registry Filesystem https://github.com/google/crfs
1. docker image history


