
variable "TAG" {
  default = "latest"
}
variable "SCRATCH" {
  default = "scratch"
}

#***********************************************
# Ubuntu images
#***********************************************

target "ubuntu-image-amd64" {
  args = {}
  context = "."
  platforms = ["linux/amd64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["55_multiarch:amd64"]
  output = ["type=docker"]
}

target "ubuntu-image-arm64" {
  args = {}
  context = "."
  platforms = ["linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["55_multiarch:arm64"]
  output = ["type=docker"]
}

target "ubuntu-image-multi" {
  args = {}
  context = "."
  platforms = ["linux/amd64", "linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["55_multiarch:latest"]
  output = ["type=docker"]
}

group "default" {
  targets = [
    "ubuntu-image-arm64",
    "ubuntu-image-amd64",
    ]
}

#    "ubuntu-image-multi"
