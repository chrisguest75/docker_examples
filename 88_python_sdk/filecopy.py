import logging
import time
import docker
from python_on_whales import docker as whales_docker
import re

logger = logging.getLogger('filecopy')


def run_filecopy_container():
    imagename = "filecopypython"

    passTest = False
    dockerfile = "Dockerfile.filecopy"
    dockerfile_path = "./"
    image_tag = f"{imagename}:1.0.0"
    port = 8080
    containername = imagename
    internal_container_path = "/scratch/README.md"

    logger.info('Building image')
    whales_docker.buildx.build(
        context_path=dockerfile_path,
        file=dockerfile,
        tags=[image_tag]
    )

    try:
        logger.info('Getting docker client')
        client = docker.from_env()
        logger.info('Cleanup old containers')
        container = client.containers.get(containername)
        container.stop()
        container.remove()
    except:
        logger.info('No old containers to cleanup')

    logger.info('Creating image')
    container = whales_docker.container.create(image_tag, publish=[(port, 80)], name=containername)

    logger.info('Copy file to container')
    #container = whales_docker.containers.from_running(containername)
    container.copy_to("./README.md", internal_container_path)

    # Get the container by ID
    logger.info('Start containers')
    container.start()

    time.sleep(1)

    logger.info('Wait for container to finish')
    whales_docker.container.wait(container)

    logger.info('Get logs from container')
    output = container.logs()
    logger.info(output)

    pattern = f'# README'

    # Use re.findall() to extract all matches of the pattern from the HTML
    matches = re.findall(pattern, output)

    # Print the matches
    for match in matches:
        logger.info(match)
        passTest = True

    logger.info('List containers')
    logger.info(whales_docker.container.list())

    logger.info('Stop containers')
    # Stop the container
    container.stop()

    #container.remove()
    return passTest

