import logging
import time
import requests
import docker
import re


logger = logging.getLogger('nginx')


def run_nginx_container(title):
    passTest = False
    logger.info('Getting docker client')
    client = docker.from_env()

    logger.info('Building image')
    dockerfile = "Dockerfile.nginx"
    dockerfile_path = "./"
    image_tag = "nginxpython:1.0.0"
    image, logs = client.images.build(
        path=dockerfile_path,
        dockerfile=dockerfile,
        tag=image_tag,
        nocache=True,
        rm=True
    )

    logger.info('Running image')
    port = 8080
    containername = 'nginxpython'

    # client.images.pull('nginxpython:1.0.0')
    client.containers.run(image_tag, detach=True, remove=False, ports={'80/tcp': port}, name=containername)

    logger.info('List containers')
    logger.info(client.containers.list())

    time.sleep(1)

    try:
        base_url = f"http://0.0.0.0:{port}"
        logger.info(f"Make request {base_url}")
        response = requests.get(f"{base_url}")
        if response.status_code != 200:
            logger.error(f"Response status code is {response.status_code}")
            # raise Exception(f"Response status code is {response.status_code}")
        else:
            logger.info(f"Response status code is {response.status_code}")
            html = response.text
            logger.info(html)

            pattern = f'<title>{title}</title>'

            # Use re.findall() to extract all matches of the pattern from the HTML
            matches = re.findall(pattern, html)

            # Print the matches
            for match in matches:
                logger.info(match)
                passTest = True

    except Exception as e:
        logger.error(f"Exception {e}")
        # raise e

    logger.info('Stop containers')
    # Get the container by ID
    container = client.containers.get(containername)

    # Stop the container
    container.stop()
    container.remove()
    return passTest
