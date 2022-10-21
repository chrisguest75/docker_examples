
variable "TAG" {
  default = "latest"
}
variable "SCRATCH" {
  default = "scratch"
}

#***********************************************
# JQ images
#***********************************************

target "jq-image" {
  args = {"NIX_FILE":"jq.nix", "PROGRAM_FILE":"jq"}
  context = "."
  dockerfile = "Dockerfile.jq"
}

target "jq-base-scratch" {
  inherits = ["jq-image"]
  args = {"baseimage":"${SCRATCH}"}
  labels = {
    "org.opencontainers.image.title"= "jq-base-scratch:${TAG}"
  }
  tags = ["jq-base-scratch:${TAG}"]
}

#***********************************************
# TODO:
# Use jq and ubuntu:22.04 with multicontext to merge the two images.  
#***********************************************

target "jq-ubuntu-final" {
  contexts = {
    imagecontext = "target:jq-base-scratch"
  }
  dockerfile = "Dockerfile.chained.final"
  args = {"baseimage":"${SCRATCH}"}
  labels = {
    "org.opencontainers.image.title"= "jq-ubuntu-final:${TAG}"
  }
  tags = ["jq-ubuntu-final:${TAG}"]
}

group "default" {
  targets = [
    "jq-base-scratch",
    "jq-ubuntu-final"
    ]
}
