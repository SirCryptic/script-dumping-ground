#!/usr/bin/python

import time
import os
import sys
import requests

print("CloudFare Resolver")

target=input('\bEnter Target : ')
r=requests.get('https://dns.google.com/query?name=' + target)
print('\bResult:')
print(r.txt)
