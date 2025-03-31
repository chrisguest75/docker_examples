
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
  args = {
    VERSION = "0.0.0+unknown"
  }
  context = "."
  platforms = ["linux/amd64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}_amd64:${IMAGE_TAG}"]
  output = ["type=docker"]

  secret = [
    # pass by file; src is the secret file location
    "type=file,id=file_secret,src=./secrets/secret_token.txt",
    # pass by environment variable
    "type=env,id=SECRET_TOKEN"
  ]
}

target "ubuntu-image-arm64" {
  args = {
    VERSION = "0.0.0+unknown"
  }
  context = "."
  platforms = ["linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}_arm64:${IMAGE_TAG}"]
  output = ["type=docker"]

  secret = [
    # pass by file; src is the secret file location
    "type=file,id=file_secret,src=./secrets/secret_token.txt",
    # pass by environment variable
    "type=env,id=SECRET_TOKEN"
  ]
}

target "ubuntu-image-multi" {
  args = {
    VERSION = "0.0.0+unknown"
  }  
  context = "."
  platforms = ["linux/amd64", "linux/arm64"]
  dockerfile = "Dockerfile.ubuntu"
  tags = ["${IMAGE_NAME}:${IMAGE_TAG}"]
  output = []
  secret = [
    # pass by file; src is the secret file location
    "type=file,id=file_secret,src=./secrets/secret_token.txt",
    # pass by environment variable
    "type=env,id=SECRET_TOKEN"
  ]  
}

group "default" {
  targets = [
    "ubuntu-image-arm64",
    "ubuntu-image-amd64",
    ]
}

#    "ubuntu-image-multi"
