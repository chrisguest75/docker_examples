import argparse
import io
import logging
import logging.config
import os
import sys
import time
import traceback
import requests

import yaml

import docker
import nginx

def log_uncaught_exceptions(exc_type, exc_value, exc_traceback):
    if issubclass(exc_type, KeyboardInterrupt):
        sys.__excepthook__(exc_type, exc_value, exc_traceback)
        return

    logging.critical("Exception", exc_info=(exc_type, exc_value, exc_traceback))
    logging.critical('Unhandled Exception {0}: {1}'.format(exc_type, exc_value), extra={'exception':''.join(traceback.format_tb(exc_traceback))})


def str2bool(v):
    return v.lower() in ("yes", "true", "t", "1")


if __name__ == "__main__":
    print(f"Enter {__name__}")
    with io.open("./logging_config.yaml") as f:         
        logging_config = yaml.load(f, Loader=yaml.FullLoader)

    logging.config.dictConfig(logging_config)
    logger = logging.getLogger()

    sys.excepthook = log_uncaught_exceptions

    parser = argparse.ArgumentParser(description='Docker tests')
    parser.add_argument('--debugger', dest='debugger', action='store_true')
    parser.add_argument('--wait', dest='wait', action='store_true')
    args = parser.parse_args()

    nginx.run_nginx_container("Hello, world!")

    exit(0)


