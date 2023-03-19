import logging
from python_on_whales import docker
import re

logger = logging.getLogger('buildx')


def run_buildx_container():
    imagename = "buildxpython"

    dockerfile = "Dockerfile.buildx"
    dockerfile_path = "./"
    image_tag = f"{imagename}:1.0.0"

    passTest = False
    logger.info('Building image')
    docker.buildx.build(
        context_path=dockerfile_path,
        file=dockerfile,
        tags=[image_tag]
    )

    returned_string = docker.run(image_tag)
    logger.info(returned_string)

    pattern = 'Hello World from buildx'

    # Use re.findall() to extract all matches of the pattern from the HTML
    matches = re.findall(pattern, returned_string)

    # Print the matches
    for match in matches:
        logger.info(match)
        passTest = True

    return passTest
