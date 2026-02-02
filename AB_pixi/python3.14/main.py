#!/usr/bin/env python3

import os 
import sys
#import requests

if __name__ == "__main__":
    print(f"Python version {sys.version}") 
    print(f"Version info. {sys.version_info}")
    print(f"Python Exe {os.path.realpath(sys.executable)}")
    #print(f"Request. {requests.get('https://api.github.com')}")