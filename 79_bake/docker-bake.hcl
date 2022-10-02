
variable "TAG" {
  default = "latest"
}
variable "DISTROLESS" {
  default = "gcr.io/distroless/nodejs:16"
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

target "jq-image-distroless" {
  inherits = ["jq-image"]
  args = {"baseimage":"${DISTROLESS}"}
  labels = {
    "org.opencontainers.image.title"= "nix-jq-distroless:${TAG}"
  }
  tags = ["nix-jq-distroless:${TAG}"]
}

target "jq-image-scratch" {
  inherits = ["jq-image"]
  args = {"baseimage":"${SCRATCH}"}
  labels = {
    "org.opencontainers.image.title"= "nix-jq-scratch:${TAG}"
  }
  tags = ["nix-jq-scratch:${TAG}"]
}

#***********************************************
# SOX images
#***********************************************

target "sox-image" {
  args = {"NIX_FILE":"sox.nix", "PROGRAM_FILE":"sox"}
  context = "."
  dockerfile = "Dockerfile.sox"
}

target "sox-image-distroless" {
  inherits = ["sox-image"]
  args = {"baseimage":"${DISTROLESS}"}
  labels = {
    "org.opencontainers.image.title"= "nix-sox-distroless:${TAG}"
  }
  tags = ["nix-sox-distroless:${TAG}"]
}

target "sox-image-scratch" {
  inherits = ["sox-image"]
  args = {"baseimage":"${SCRATCH}"}
  labels = {
    "org.opencontainers.image.title"= "nix-sox-scratch:${TAG}"
  }
  tags = ["nix-sox-scratch:${TAG}"]
}

#***********************************************
# ffmpeg images
#***********************************************

target "ffmpeg-image" {
  args = {"NIX_FILE":"ffmpeg-full.nix", "PROGRAM_FILE":"ffmpeg"}
  context = "."
  dockerfile = "Dockerfile.ffmpeg"
}

target "ffmpeg-image-distroless" {
  inherits = ["ffmpeg-image"]
  args = {"baseimage":"${DISTROLESS}"}
  labels = {
    "org.opencontainers.image.title"= "nix-ffmpeg-distroless:${TAG}"
  }
  tags = ["nix-ffmpeg-distroless:${TAG}"]
}

target "ffmpeg-image-scratch" {
  inherits = ["ffmpeg-image"]
  args = {"baseimage":"${SCRATCH}"}
  labels = {
    "org.opencontainers.image.title"= "nix-ffmpeg-scratch:${TAG}"
  }
  tags = ["nix-ffmpeg-scratch:${TAG}"]
}

group "default" {
  targets = [
    "jq-image-distroless", 
    "jq-image-scratch",
    "sox-image-distroless", 
    "sox-image-scratch",
    "ffmpeg-image-distroless", 
    "ffmpeg-image-scratch"
    ]
}
