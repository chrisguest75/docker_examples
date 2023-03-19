import logging
import docker

logger = logging.getLogger('buildx')


def run_buildx_container():
    imagename = "buildxpython"

    passTest = False
    logger.info('Getting docker client')
    client = docker.from_env()

    dockerfile = "Dockerfile.filecopy"
    dockerfile_path = "./"
    image_tag = f"{imagename}:1.0.0"

    # Create a Buildx builder
    logger.info('Creating Buildx builder')
    builder = client.api.buildx_create(name="88_python_sdk")

    # Build a Docker image using the Buildx builder
    logger.info('Building image')
    image, logs = client.images.build(
        path=dockerfile_path,
        dockerfile=dockerfile,
        tag=image_tag,
        builder=f"buildx://{builder.id}"
    )

    return passTest

