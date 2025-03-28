
variable "IMAGE_NAME" {
  default = "55_multiarch"
}
variable "IMAGE_TAG" {
  default = "latest"
}

#***********************************************
# Ubuntu images
#***********************************************

target "ubuntu-image-amd64" {
  args = {}
  context = "."
  platforms = ["linux/amd64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}_amd64:${IMAGE_TAG}"]
  output = ["type=docker"]
}

target "ubuntu-image-arm64" {
  args = {}
  context = "."
  platforms = ["linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}_arm64:${IMAGE_TAG}"]
  output = ["type=docker"]
}

target "ubuntu-image-multi" {
  args = {}
  context = "."
  platforms = ["linux/amd64", "linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}:${IMAGE_TAG}"]
  output = []
}

group "default" {
  targets = [
    "ubuntu-image-arm64",
    "ubuntu-image-amd64",
    ]
}

#    "ubuntu-image-multi"
