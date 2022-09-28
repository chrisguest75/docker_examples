variable "TAG" {
  default = "latest"
}

target "_common" {
  args = {
    BUILDKIT_CONTEXT_KEEP_GIT_DIR = 1
  }
}

// docker-bake.hcl
target "docker-metadata-action" {
  tags = ["nix-jq:${TAG}"]
}

group "default" {
  targets = ["image"]
}

target "image" {
 inherits = ["_common", "docker-metadata-action"]
 context = "."
 dockerfile = "Dockerfile.jq"
 #cache-from = ["type=registry,ref=${GITHUB_REPOSITORY_OWNER}/hello-world-buildx:latest"]
 #cache-to = ["type=inline"]
 labels = {
   "org.opencontainers.image.title"= "nix-jq:${TAG}"
 }
 #output = ["type=registry"]
}

target "image-all" {
 inherits = ["image"]
 platforms = ["linux/amd64"]
 output = ["type=registry"]
}