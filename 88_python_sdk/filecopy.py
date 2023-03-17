import logging
import time
import requests
import docker
import re

import logging

logger = logging.getLogger('filecopy')

def run_filecopy_container():
    imagename = "filecopypython"

    passTest = False
    logger.info('Getting docker client')
    client = docker.from_env()

    logger.info('Building image')
    dockerfile = "Dockerfile.filecopy"
    dockerfile_path = "./"
    image_tag = f"{imagename}:1.0.0"
    image, logs = client.images.build(
        path=dockerfile_path,
        dockerfile=dockerfile,
        tag=image_tag,
        nocache=True,
        rm=True
    )

    logger.info('Running image')
    port = 8080
    containername = imagename
    #client.images.pull('nginxpython:1.0.0')
    client.containers.create(image_tag, detach=True, remove=False, ports={'80/tcp': port}, name=containername)

    internal_container_path = "/shared/README.md"
    # Open the file and create a tar archive
    with open("./README.md", 'rb') as file:
        data = file.read()
    tar_data = docker.utils.tar.encode({container_path: data})

    # Copy the tar archive to the container
    client.api.put_archive(containername, internal_container_path, tar_data)

    # Get the container by ID
    container = client.containers.get(containername)
    container.start()

    time.sleep(1)

    logger.info('List containers')
    logger.info(client.containers.list())

    logger.info('Stop containers')
    # Stop the container
    container.stop()



    #container.remove()
    return passTest

