#!/usr/bin/python
import sys
import socket
from netaddr import *

if len(sys.argv) < 2:
    sys.exit('\nUsage: %s 192.168.1.0/24\n' % sys.argv[0])

subnet = sys.argv[1]

for ip in IPNetwork(subnet): print '%s' % ip

